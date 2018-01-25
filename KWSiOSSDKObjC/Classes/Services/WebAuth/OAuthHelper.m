//
//  OAuthHelper.m
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 25/01/2018.
//


#import "OAuthHelper.h"

#import <CommonCrypto/CommonDigest.h>

@implementation OAuthHelper

NSUInteger const numberBytesToEncode = 32;
NSString *const CODE_CHALLENGE_METHOD = @"S256";

+ (NSString*) generateCodeVerifier{
    return [self randomURLSafeStringWithSize: numberBytesToEncode];
}


+ (NSString*) generateCodeChallenge: (NSString*) verifier {
    
    u_int8_t buffer[CC_SHA256_DIGEST_LENGTH * sizeof(u_int8_t)];
    memset(buffer, 0x0, CC_SHA256_DIGEST_LENGTH);
    NSData *data = [verifier dataUsingEncoding:NSUTF8StringEncoding];
    CC_SHA256([data bytes], (CC_LONG)[data length], buffer);
    NSData *hash = [NSData dataWithBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
    NSString *challenge = [[[[hash base64EncodedStringWithOptions:0]
                             stringByReplacingOccurrencesOfString:@"+" withString:@"-"]
                            stringByReplacingOccurrencesOfString:@"/" withString:@""]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
    
    return challenge;
}


+ (nullable NSString *)randomURLSafeStringWithSize:(NSUInteger)size {
    NSMutableData *randomData = [NSMutableData dataWithLength:size];
    int result = SecRandomCopyBytes(kSecRandomDefault, randomData.length, randomData.mutableBytes);
    if (result != 0) {
        return nil;
    }
    return [self encodeBase64WithoutPadding:randomData];
}

+ (NSString *)encodeBase64WithoutPadding:(NSData *)data {
    
    NSString *base64string = [data base64EncodedStringWithOptions:0];
    
    // converts base64 to base64url
    base64string = [base64string stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64string = [base64string stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    // strips padding
    base64string = [base64string stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    return base64string;
}


@end
