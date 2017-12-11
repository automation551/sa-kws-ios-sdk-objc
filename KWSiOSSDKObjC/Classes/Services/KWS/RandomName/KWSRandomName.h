//
//  KWSRandomName.h
//  Pods
//
//  Created by Gabriel Coman on 20/12/2016.
//
//

#import "KWSService.h"

typedef void (^KWSChildrenGetRandomUsernameBlock)(NSString *name);

@interface KWSRandomName : KWSService
- (void) execute:(NSInteger)appId
        onResult:(KWSChildrenGetRandomUsernameBlock)gotName;
@end
