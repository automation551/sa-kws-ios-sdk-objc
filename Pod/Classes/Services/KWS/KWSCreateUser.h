//
//  KWSCreateUser.h
//  Pods
//
//  Created by Gabriel Coman on 07/10/2016.
//
//

#import "KWSService.h"

// forward decl
@class KWSLoggedUser;

typedef void (^created)(NSInteger status, KWSLoggedUser *loggedUser);

@interface KWSCreateUser : KWSService

- (void) executeWithCreatedUser:(KWSLoggedUser*)loggedUser
                               : (created) created;
@end
