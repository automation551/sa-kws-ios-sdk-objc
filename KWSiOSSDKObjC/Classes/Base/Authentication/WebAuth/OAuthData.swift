//
//  OAuthData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation

public struct OAuthData {
    let codeChallenge: String
    let codeVerifier: String
    let codeChallengeMethod: String
}
