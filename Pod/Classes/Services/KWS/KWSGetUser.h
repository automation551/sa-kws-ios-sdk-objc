//
//  KWSGetUser.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSRequest.h"
#import "KWSUser.h"

// callback
typedef void (^gotUser)(KWSUser* user);

@interface KWSGetUser : KWSRequest
- (void) execute:(gotUser)gotuser;
@end
