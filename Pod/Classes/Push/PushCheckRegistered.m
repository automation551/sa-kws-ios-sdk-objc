//
//  PushRegisterPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushCheckRegistered.h"
#import "KWSSystemVersion.h"

@interface PushCheckRegistered ()
@property (nonatomic, weak) UIApplication *appRef;
@end

@implementation PushCheckRegistered

// MARK: Init functions

- (id) init {
    if (self = [super init]) {
        _appRef = [UIApplication sharedApplication];
    }
    return self;
}

// MARK: Main class functions

- (void) isRegistered {
    
    BOOL isRegistered = false;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationSettings *settings = [_appRef currentUserNotificationSettings];
        isRegistered = (settings.types & UIRemoteNotificationTypeAlert);
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

// MARK: Delegate handler functions

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
