//
//  OAuthHelper.h
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 25/01/2018.
//

#ifndef OAuthHelper_h
#define OAuthHelper_h


#endif /* OAuthHelper_h */

#import <Foundation/Foundation.h>

@interface OAuthHelper : NSObject

extern NSUInteger const numberBytesToEncode;
extern NSString *const CODE_CHALLENGE_METHOD;

+ (NSString*) generateCodeVerifier;

+ (NSString*) generateCodeChallenge: (NSString*) verifier;

/*! @brief Base64url without padding encodes the given data.
 @param data The data to input.
 @return The base64url encoded data as NSString.
 @discussion Base64url without padding is used in PKCE flow
 */
+ (NSString *) encodeBase64WithoutPadding: (NSData *) data;

/*! @brief Generates URL-safe string of random data.
 @param size The number of random bytes to encode - length of the output string will be
 greater than the number of random bytes, due to the URL-safe encoding.
 @return Random data encoded with base64url .
 */
+ (nullable NSString *)randomURLSafeStringWithSize:(NSUInteger)size;



@end
