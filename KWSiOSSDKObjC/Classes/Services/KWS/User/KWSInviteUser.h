//
//  KWSInviteUser.h
//  Pods
//
//  Created by Gabriel Coman on 24/08/2016.
//
//

#import "KWSService.h"

typedef void (^KWSChildrenInviteUserBlock)(BOOL invited);

@interface KWSInviteUser : KWSService
- (void) execute:(NSString*) email
                :(KWSChildrenInviteUserBlock)invited;
@end
