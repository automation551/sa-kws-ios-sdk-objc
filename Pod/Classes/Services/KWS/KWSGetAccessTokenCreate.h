//
//  KWSOAuthService.h
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import "KWSService.h"

typedef void (^gotAccessTokenCreate)(NSString* token);

@interface KWSGetAccessTokenCreate : KWSService
- (void) execute:(gotAccessTokenCreate) gotAccessTokenCreate;
@end
