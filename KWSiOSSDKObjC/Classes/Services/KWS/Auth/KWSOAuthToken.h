//
//  KWSOAuthToken.h
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 25/01/2018.
//

#import "KWSService.h"

@class KWSAccessToken;
@class KWSLoggedUser;

typedef void (^authenticated)(NSInteger status, KWSLoggedUser *user);

@interface KWSOAuthToken : KWSService

- (void) execute: (NSString*) authCode
withCodeVerifier: (NSString*) codeVerifider
                :(authenticated) authenticated;

@end
