//
//  KWSGetUser.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import "KWSService.h"
#import "KWSUser.h"

typedef void (^gotUser)(KWSUser* user);

@interface KWSGetUser : KWSService
- (void) execute:(gotUser)gotuser;
@end
