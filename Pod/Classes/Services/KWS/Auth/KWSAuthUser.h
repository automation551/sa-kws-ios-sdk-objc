//
//  KWSAuthUser.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import "KWSService.h"

@class KWSAccessToken;

typedef void (^authenticated)(NSInteger status, KWSLoggedUser *user);

@interface KWSAuthUser : KWSService
- (void) execute:(NSString*)username andPassword:(NSString*)password :(authenticated) authenticated;
@end
