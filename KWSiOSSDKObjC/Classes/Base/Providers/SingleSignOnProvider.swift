//
//  SingleSignOnProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class SingleSignOnProvider: NSObject, SingleSignOnServiceProtocol {
    
    var environment: KWSNetworkEnvironment
    private var kwsWebAuthresponse: WebAuthController!
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func signOn(url: String, parent: UIViewController, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let oAuthCodeGenerator = OAuthCodeTask()
        let oAuthDataClass = oAuthCodeGenerator.execute(input: ())
        
        getOAuthCode(environment: self.environment,
                     parent: parent,
                     singleSignOnUrl: url,
                     codeChallenge: oAuthDataClass.codeChallenge,
                     codeChallengeMethod: oAuthDataClass.codeChallengeMethod) { (code, error) in
                        
                        if let authCode = code {
                            self.getAccessToken(environment: self.environment,
                                                authCode: authCode,
                                                codeVerifier: oAuthDataClass.codeVerifier,
                                                completionHandler: completionHandler)
                        }
        }
        
    }
    
    private func getOAuthCode(environment: KWSNetworkEnvironment, parent: UIViewController, singleSignOnUrl: String, codeChallenge: String, codeChallengeMethod: String,
                              completionHandler: @escaping (String?, Error?) -> ()){
        
        var completeUrl = ""
        let endpoint = "oauth"
        let clientId = environment.clientID
        
        if let redirectUri = Bundle.main.bundleIdentifier {
             completeUrl = singleSignOnUrl + endpoint + "?clientId=\(clientId)&codeChallenge=\(codeChallenge)&codeChallengeMethod=\(codeChallengeMethod)&redirectUri=\(redirectUri)://"
        }
        
        if let actualURL = URL.init(string: completeUrl), !(completeUrl.isEmpty) {
            
            kwsWebAuthresponse = WebAuthController(authURL: actualURL, parent: parent) { (authCodeResponse) in
                
                if let code = authCodeResponse {
                    completionHandler(code, nil)
                } else {
                    completionHandler(nil, KWSBaseError(message: "Error getting auth code from web view!"))
                }
            }
        } else {
              completionHandler(nil, KWSBaseError(message: "Empty URI for OAuth..."))
        }
    }
    
    private func getAccessToken(environment: KWSNetworkEnvironment,
                                authCode: String,
                                codeVerifier: String, completionHandler: @escaping (LoggedUser?, Error?) -> ()) {
        
        let getOAuthTokenNetworkRequest = OAuthUserTokenRequest(environment: environment,
                                                                clientID: environment.clientID,
                                                                authCode: authCode,
                                                                codeVerifier: codeVerifier,
                                                                clientSecret: environment.clientSecret)
        
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
