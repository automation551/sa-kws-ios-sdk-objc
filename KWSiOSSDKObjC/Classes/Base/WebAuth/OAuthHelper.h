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
#import "OAuthData.h"

@interface OAuthHelper : NSObject

extern NSUInteger const numberBytesToEncode;

// enum to define permissions
typedef NS_ENUM(NSInteger, OAuthChallengeMethod) {
    S256 = 0,
    PLAIN = 1
};

- (OAuthData*) execute;

- (NSString*) generateCodeChallenge: (NSString*) verifier;

- (NSString*) generateCodeVerifier;

@end
