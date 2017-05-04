//
//  PushCheckPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushCheckAllowed.h"
#import "SAUtils.h"

#define kUserHasSeenDialog @"UserHasSeenDialog"

@interface PushCheckAllowed ()
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, weak) UIApplication *appRef;
@property (nonatomic, assign) Boolean hasUserSeenDialog;
@end

@implementation PushCheckAllowed

// MARK: Init function

- (id) init {
    if (self = [super init]) {
        
    }
    return self;
}

// MARK: Main class function

- (void) check {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _appRef = [UIApplication sharedApplication];
    if ([_defaults objectForKey:kUserHasSeenDialog] != NULL) {
        _hasUserSeenDialog = [_defaults boolForKey:kUserHasSeenDialog];
    }
    
    if (!_hasUserSeenDialog) {
        [self delPushAllowedInSystem];
        return;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationSettings *settings = [_appRef currentUserNotificationSettings];
        if (settings != NULL) {
            if (settings.types != UIUserNotificationTypeNone) {
                [self delPushAllowedInSystem];
                return;
            }
            [self delPushNotAllowedInSystem];
            return;
        }
        [self delPushNotAllowedInSystem];
        return;
    }
    else {
        UIRemoteNotificationType types = [_appRef enabledRemoteNotificationTypes];
        
        if (types & UIRemoteNotificationTypeAlert) {
            [self delPushAllowedInSystem];
            return;
        }else {
            [self delPushNotAllowedInSystem];
            return;
        }
    }
}

// MARK: Delegate handler functions

- (void) markSystemDialogAsSeen {
    _defaults = [NSUserDefaults standardUserDefaults];
    _hasUserSeenDialog = true;
    [_defaults setBool:_hasUserSeenDialog forKey:kUserHasSeenDialog];
    [_defaults synchronize];
}

- (void) delPushAllowedInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushAllowedInSystem)]) {
        [_delegate pushAllowedInSystem];
    }
}

- (void) delPushNotAllowedInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushNotAllowedInSystem)]) {
        [_delegate pushNotAllowedInSystem];
    }
}
@end
