//
//  PushRegisterPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushRegisterPermission.h"
#import "KWSSystemVersion.h"

@interface PushRegisterPermission ()
@property (nonatomic, weak) UIApplication *appRef;
@end

@implementation PushRegisterPermission

- (id) init {
    if (self = [super init]) {
        _appRef = [UIApplication sharedApplication];
    }
    return self;
}

- (void) isRegistered {
    
    BOOL isRegistered = false;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        isRegistered = ([_appRef isRegisteredForRemoteNotifications]);
    }
    else {
        UIRemoteNotificationType types = [_appRef enabledRemoteNotificationTypes];
        isRegistered = (types & UIRemoteNotificationTypeAlert);
    }
    
    if (isRegistered) {
        [self delIsRegisteredInSystem];
    } else {
        [self delIsNotRegisteredInSystem];
    }
}

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

// <Delegate> functions

- (void) delIsRegisteredInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isRegisteredInSystem)]) {
        [_delegate isRegisteredInSystem];
    }
}

- (void) delIsNotRegisteredInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isNotRegisteredInSystem)]) {
        [_delegate isNotRegisteredInSystem];
    }
}
@end
