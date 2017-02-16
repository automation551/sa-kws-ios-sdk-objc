//
//  KWSHasTriggeredEvent.h
//  Pods
//
//  Created by Gabriel Coman on 24/08/2016.
//
//

#import "KWSService.h"

typedef void (^KWSChildrenHasTriggeredEventBlock)(BOOL triggered);

@interface KWSHasTriggeredEvent : KWSService
- (void) execute:(NSInteger)eventId
                :(KWSChildrenHasTriggeredEventBlock)triggered;
@end
