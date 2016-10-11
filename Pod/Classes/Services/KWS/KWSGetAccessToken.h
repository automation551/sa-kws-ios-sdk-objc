//
//  KWSOAuthService.h
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import "KWSService.h"

typedef void (^gotAccessToken)(NSString* token);

@interface KWSGetAccessToken : KWSService
- (void) execute:(gotAccessToken) gotAccessToken;
@end
