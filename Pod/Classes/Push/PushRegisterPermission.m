//
//  PushRegisterPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushRegisterPermission.h"

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
    BOOL isRegistered = [_appRef isRegisteredForRemoteNotifications];
    if (isRegistered) {
        [self delIsRegisteredInSystem];
    } else {
        [self delIsNotRegisteredInSystem];
    }
}

- (void) registerPush {
    [_appRef registerForRemoteNotifications];
}

- (void) unregisterPush {
    [_appRef unregisterForRemoteNotifications];
}

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
