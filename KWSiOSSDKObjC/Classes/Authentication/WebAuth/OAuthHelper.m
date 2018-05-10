//
//  OAuthHelper.m
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 25/01/2018.
//

#import "OAuthHelper.h"
#import <CommonCrypto/CommonDigest.h>

#import "KWSiOSSDKObjC/KWSiOSSDKObjC-Swift.h"

//@class OAuthData;

@implementation OAuthHelper

NSUInteger const numberBytesToEncode = 32;

- (NSString*) generateCodeVerifier{
    return [self randomURLSafeStringWithSize: numberBytesToEncode];
}


- (NSString*) generateCodeChallenge: (NSString*) verifier {
    
    NSData *sha256Verifier = [self sha265:verifier];
    NSString *challenge = [self encodeBase64WithoutPadding: sha256Verifier];
    return challenge;
}


- (nullable NSString *)randomURLSafeStringWithSize:(NSUInteger)size {
    NSMutableData *randomData = [NSMutableData dataWithLength:size];
    int result = SecRandomCopyBytes(kSecRandomDefault, randomData.length, randomData.mutableBytes);
    if (result != 0) {
        return nil;
    }
    return [self encodeBase64WithoutPadding:randomData];
}

- (NSString *)encodeBase64WithoutPadding:(NSData *)data {
    
    NSString *base64string = [data base64EncodedStringWithOptions:0];
    
    // converts base64 to base64url
    base64string = [base64string stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64string = [base64string stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    // strips padding
    base64string = [base64string stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    return base64string;
}

- (NSData *)sha265:(NSString *)inputString {
    NSData *verifierData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *sha256Verifier = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(verifierData.bytes, (CC_LONG)verifierData.length, sha256Verifier.mutableBytes);
    return sha256Verifier;
}
@end
