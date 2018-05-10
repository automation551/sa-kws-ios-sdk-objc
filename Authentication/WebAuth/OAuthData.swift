//
//  OAuthData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation

@objc
public class OAuthData: NSObject {
    
    let codeChallenge:       String
    let codeVerifier:        String
    let codeChallengeMethod: String
    
    public init (codeChallenge:       String,
                 codeVerifier:        String,
                 codeChallengeMethod: String) {
        
        self.codeChallenge = codeChallenge
        self.codeVerifier = codeVerifier
        self.codeChallengeMethod = codeChallengeMethod
    }
    
}
