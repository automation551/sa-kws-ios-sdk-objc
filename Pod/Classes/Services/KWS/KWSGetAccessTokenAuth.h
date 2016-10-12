//
//  KWSAuthUser.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import "KWSService.h"

typedef void (^gotAccessTokenAuth)(NSString* token);

@interface KWSGetAccessTokenAuth : KWSService
- (void) execute:(NSString*)username andPassword:(NSString*)password :(gotAccessTokenAuth) gotAccessTokenAuth;
@end
