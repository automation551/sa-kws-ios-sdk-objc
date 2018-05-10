//
//  OAuthCodeTask.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation
import SAMobileBase

public class OAuthCodeTask: TaskProtocol {
    
    public typealias Input = Any?
    public typealias Output = OAuthData    
    
    public init() {
        // do nothing
    }
    
    enum OAuthEncoding: String {
        case UsASCII = "US-ASCII"
    }
    
    enum OAuthDigest: String {
        case Sha256 = "SHA-256"
    }
    
    enum OAuthChallenge: String {
        case S256 = "S256"
        case Plain = "plain"
    }
    
    public func execute(input: Any?) -> OAuthData {
        
        let codeChallengeMethod = OAuthChallenge.S256
        
        //OAuthHelper is a ObjC class as per the CommonCrypto framework needing to be imported
        let oauthHelper = OAuthHelper.init()
        if let codeVerifier = oauthHelper.generateCodeVerifier(), let codeChallenge = oauthHelper.generateCodeChallenge(codeVerifier){
            return OAuthData(codeChallenge: codeChallenge, codeVerifier: codeVerifier, codeChallengeMethod: codeChallengeMethod.rawValue)
        } else {
            return OAuthData(codeChallenge: "", codeVerifier: "", codeChallengeMethod: codeChallengeMethod.rawValue)
        }        
    }
}
