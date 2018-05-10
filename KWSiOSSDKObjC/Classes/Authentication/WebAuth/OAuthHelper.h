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

@class OAuthData;

@interface OAuthHelper : NSObject

extern NSUInteger const numberBytesToEncode;

- (NSString*) generateCodeChallenge: (NSString*) verifier;

- (NSString*) generateCodeVerifier;

@end
