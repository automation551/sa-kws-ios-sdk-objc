//
//  NotificationProcess.m
//  Pods
//
//  Created by Gabriel Coman on 05/08/2016.
//
//

// import header
#import "NotificationProcess.h"

// import other headers
#import "KWSCheckAllowed.h"
#import "KWSCheckRegistered.h"
#import "KWSRequestPermission.h"
#import "KWSRegisterToken.h"
#import "KWSUnregisterToken.h"
#import "SystemCheckAllowed.h"
#import "FirebaseGetToken.h"

// other utils
#import "SASystemVersion.h"

@interface NotificationProcess ()
// objects
@property (nonatomic, strong) KWSCheckAllowed *checkAllowed;
@property (nonatomic, strong) KWSCheckRegistered *checkRegistered;
@property (nonatomic, strong) KWSRequestPermission *requestPermission;
@property (nonatomic, strong) KWSRegisterToken *registerToken;
@property (nonatomic, strong) KWSUnregisterToken *unregisterToken;
@property (nonatomic, strong) SystemCheckAllowed *checkSystem;
@property (nonatomic, strong) FirebaseGetToken *getToken;

@property (nonatomic, weak) UIApplication *appRef;
@end

@implementation NotificationProcess

- (id) init {
    if (self = [super init]) {
        _checkAllowed = [[KWSCheckAllowed alloc] init];
        _checkRegistered = [[KWSCheckRegistered alloc] init];
        _requestPermission = [[KWSRequestPermission alloc] init];
        _registerToken = [[KWSRegisterToken alloc] init];
        _unregisterToken = [[KWSUnregisterToken alloc] init];
        _checkSystem = [[SystemCheckAllowed alloc] init];
        _getToken = [[FirebaseGetToken alloc] init];
        
        _appRef = [UIApplication sharedApplication];
    }
    
    return self;
}

- (void) register:(registered)reg {
    
    // make sure it won't cause any problems down the road
    __block registered registered = reg ? reg : ^(BOOL success, KWSErrorType type){};
    
    [_checkSystem execute:^(BOOL allowed) {
        if (!allowed) {
            registered(false, UserHasDisabledRemoteNotifications);
            return;
        }
        
        [_checkAllowed execute:^(BOOL success, BOOL allowed) {
            if (!success) {
                registered(false, FailedToCheckIfUserHasNotificationsEnabledInKWS);
                return;
            }
            
            if (!allowed) {
                registered(false, ParentHasDisabledRemoteNotifications);
                return;
            }
            
            [_requestPermission execute:@[@(sendPushNotification)] :^(BOOL success, BOOL requested) {
                if (!success) {
                    registered(false, FailedToRequestNotificationsPermissionInKWS);
                    return;
                }
                
                if (!requested) {
                    registered(false, UserHasNoParentEmail);
                    return;
                }
                
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
                    UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
                    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
                    [_appRef registerUserNotificationSettings:settings];
                    [_appRef registerForRemoteNotifications];
                } else {
                    UIRemoteNotificationType allNotificationTypes = (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge);
                    [_appRef registerForRemoteNotificationTypes:allNotificationTypes];
                }
                
                // mark this
                [_checkSystem markSystemDialogAsSeen];
                
                [_getToken execute:^(BOOL sucess, NSString *token) {
                    if (!success) {
                        registered(false, FirebaseCouldNotGetToken);
                        return;
                    }
                    
                    [_registerToken execute:token :^(BOOL success) {
                        if (!success) {
                            registered(false, FailedToSubscribeTokenToKWS);
                        } else {
                            registered(true, kNilOptions);
                        }
                    }];
                }];
            }];
        }];
    }];
    
}

- (void) unregister:(unregistered)unreg {
    // make sure thare are no problems here
    __block unregistered unregistered = unreg ? unreg : ^(BOOL success){};
    NSString *token = [_getToken getSavedToken];
    
    // call func
    [_unregisterToken execute:token :^(BOOL success) {
        unregistered(success);
    }];
}

- (void) isRegistered:(isRegistered)isReg {
    // make sure no problems will appear
    __block isRegistered isRegistered = isReg ? isReg : ^(BOOL success){};
    
    // check
    [_checkSystem execute:^(BOOL allowed) {
        if (!allowed) {
            isRegistered(false);
            return;
        }
        
        [_checkAllowed execute:^(BOOL success, BOOL allowed) {
            if (!success) {
                isRegistered(false);
                return;
            }
            if (!allowed) {
                isRegistered(false);
                return;
            }
            
            [_checkRegistered execute:^(BOOL success, BOOL registered) {
                if (!success) {
                    isRegistered(false);
                } else {
                    isRegistered(registered);
                }
            }];
        }];
    }];
}

@end
