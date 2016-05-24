//
//  PushCheckPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushCheckPermission.h"
#import "KWSSystemVersion.h"

#define kUserHasSeenDialog @"UserHasSeenDialog"

@interface PushCheckPermission ()
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, weak) UIApplication *appRef;
@property (nonatomic, assign) Boolean hasUserSeenDialog;
@end

@implementation PushCheckPermission

- (id) init {
    if (self = [super init]) {
        _defaults = [NSUserDefaults standardUserDefaults];
        _appRef = [UIApplication sharedApplication];
        if ([_defaults objectForKey:kUserHasSeenDialog] != NULL) {
            _hasUserSeenDialog = [_defaults boolForKey:kUserHasSeenDialog];
        }
    }
    return self;
}

- (void) check {
    
    if (!_hasUserSeenDialog) {
        [self delPushEnabledInSystem];
        return;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationSettings *settings = [_appRef currentUserNotificationSettings];
        if (settings != NULL) {
            if (settings.types != UIUserNotificationTypeNone) {
                [self delPushEnabledInSystem];
                return;
            }
            [self delPushDisabledInSystem];
            return;
        }
        [self delPushDisabledInSystem];
        return;
    }
    else {
        UIRemoteNotificationType types = [_appRef enabledRemoteNotificationTypes];
        
        if (types & UIRemoteNotificationTypeAlert) {
            [self delPushEnabledInSystem];
            return;
        }else {
            [self delPushEnabledInSystem];
            return;
        }
    }
}

// <Delegate> functions

- (void) markSystemDialogAsSeen {
    _hasUserSeenDialog = true;
    [_defaults setBool:_hasUserSeenDialog forKey:kUserHasSeenDialog];
    [_defaults synchronize];
}

- (void) delPushEnabledInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushEnabledInSystem)]) {
        [_delegate pushEnabledInSystem];
    }
}

- (void) delPushDisabledInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushDisabledInSystem)]) {
        [_delegate pushDisabledInSystem];
    }
}
@end
