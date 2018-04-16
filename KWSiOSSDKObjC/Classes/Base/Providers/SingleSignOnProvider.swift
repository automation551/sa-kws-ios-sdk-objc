//
//  SingleSignOnProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs
import SafariServices

public class SingleSignOnProvider: NSObject, SingleSignOnServiceProtocol, SFSafariViewControllerDelegate {
    
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func signOn(url: String, parent: UIViewController, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let oAuthCodeGenerator = OAuthCodeTask()
        let oAuthDataClass = oAuthCodeGenerator.execute(input: ())
        
        if let actualURL = URL.init(string: url) {
            
            let safariVC = SFSafariViewController.init(url: actualURL)
            safariVC.delegate = self
            parent.present(safariVC, animated: true, completion: nil)
            
        }
        //TODO
        print("OAuth data codeChallenge:\(oAuthDataClass.codeChallenge)\nOAuth data code verifier: \(oAuthDataClass.codeVerifier)\nOAuth data code method: \(oAuthDataClass.codeChallengeMethod)")
        
        
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func getAuthCode(){
        
    }
    
    private func getAccessToken(environment: KWSNetworkEnvironment,
                                authCode: String,
                                codeVerifier: String, completionHandler: @escaping (LoggedUser?, Error?) -> ()) {
        
        let getOAuthTokenNetworkRequest = OAuthUserTokenRequest(environment: environment,
                                                                clientID: environment.appID,
                                                                authCode: authCode,
                                                                codeVerifier: codeVerifier,
                                                                clientSecret: environment.mobileKey)
        
        let parseTask = ParseJsonTask<LoginAuthResponse>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: getOAuthTokenNetworkRequest)
            .map { (result: Result<String>) -> Result <LoginAuthResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                
                let token = value.token
                
                let base64Task = ParseBase64Task()
                let parseTask = ParseJsonTask<TokenData>()
                let tokenResult = base64Task.execute(input: token).then(parseTask.execute)
                
                switch tokenResult {
                case .success(let tokenData):
                    if let userId = tokenData.userId {
                        let user = LoggedUser(token: token, tokenData: tokenData, id: userId)
                        completionHandler(user, nil)
                    }
                case .error(let error):
                    let mappedError = Provider().mapErrorResponse(error: error)
                    completionHandler(nil, mappedError)
                }
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
            }
        }
    }
    
}
