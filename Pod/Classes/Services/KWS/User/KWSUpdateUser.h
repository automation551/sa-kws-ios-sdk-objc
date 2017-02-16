//
//  KWSUpdateUser.h
//  Pods
//
//  Created by Gabriel Coman on 25/08/2016.
//
//

#import "KWSService.h"
#import "KWSUser.h"

typedef void (^KWSChildrenUpdateUserBlock)(BOOL updated);

@interface KWSUpdateUser : KWSService
- (void) execute:(KWSUser*)updatedUser
                :(KWSChildrenUpdateUserBlock)updated;
@end
