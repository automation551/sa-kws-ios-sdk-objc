//
//  PushRegister.m
//  Pods
//
//  Created by Gabriel Coman on 30/06/2016.
//
//

#import "PushRegister.h"
#import "KWSSystemVersion.h"

@interface PushRegister ()
@property (nonatomic, weak) UIApplication *appRef;
@end

@implementation PushRegister

// MARK: Init

- (id) init {
    if (self = [super init]) {
        _appRef = [UIApplication sharedApplication];
    }
    return self;
}

// MARK: Main class functions

- (void) registerPush {
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [_appRef registerForRemoteNotifications];
    }
    else {
        UIRemoteNotificationType type = (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound);
        [_appRef registerForRemoteNotificationTypes:type];
    }
}

- (void) unregisterPush {
    [_appRef unregisterForRemoteNotifications];
}

@end
