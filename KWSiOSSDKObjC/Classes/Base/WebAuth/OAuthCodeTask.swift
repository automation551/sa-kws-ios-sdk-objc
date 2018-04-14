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
        let codeVerifier = self.generateCodeVerifier()
        let codeChallenge = self.generateCodeChallenge(codeVerifier: codeVerifier!)
        let codeChallengeMethod = OAuthChallenge.S256
        
        return OAuthData(codeChallenge: codeChallenge!, codeVerifier: codeVerifier!, codeChallengeMethod: codeChallengeMethod.rawValue)
    }
    
    private func generateCodeVerifier() -> String? {
        
        var keyData = Data(count: 32)
        let result = keyData.withUnsafeMutableBytes {
            (mutableBytes: UnsafeMutablePointer<UInt8>) -> Int32 in
            SecRandomCopyBytes(kSecRandomDefault, keyData.count, mutableBytes)
        }
        if result == errSecSuccess {
            return base64UrlEncode(keyData)
        } else {
            // TODO: handle error
            return nil
        }
    }
    
    private func base64UrlEncode(_ data: Data) -> String {
        var b64 = data.base64EncodedString()
        b64 = b64.replacingOccurrences(of: "=", with: "")
        b64 = b64.replacingOccurrences(of: "+", with: "-")
        b64 = b64.replacingOccurrences(of: "/", with: "_")
        return b64
    }
    
    private func generateCodeChallenge(codeVerifier: String) -> String? {
//        guard let data = verifier.data(using: .utf8) else { return nil }
//        var buffer = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA256($0, CC_LONG(data.count), &buffer)
//        }
//        let hash = Data(bytes: buffer)
//        let challenge = hash.base64EncodedString()
//            .replacingOccurrences(of: "+", with: "-")
//            .replacingOccurrences(of: "/", with: "_")
//            .replacingOccurrences(of: "=", with: "")
//            .trimmingCharacters(in: .whitespaces)
        
        return ""
    }
    
}
