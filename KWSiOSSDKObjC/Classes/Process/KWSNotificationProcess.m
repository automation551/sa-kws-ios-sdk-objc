//
//  NotificationProcess.m
//  Pods
//
//  Created by Gabriel Coman on 05/08/2016.
//
//

// import header
#import "KWSNotificationProcess.h"

// import other headers
#import "KWSCheckAllowed.h"
#import "KWSCheckRegistered.h"
#import "KWSRequestPermission.h"
#import "KWSRegisterToken.h"
#import "KWSUnregisterToken.h"
#import "SystemCheckAllowed.h"
#import "FirebaseGetToken.h"
#import "KWSChildren.h"

// other utils
#import "SAUtils.h"

@interface KWSNotificationProcess ()
// objects
@property (nonatomic, strong) KWSCheckAllowed *checkAllowed;
@property (nonatomic, strong) KWSCheckRegistered *checkRegistered;
@property (nonatomic, strong) KWSRequestPermission *requestPermission;
@property (nonatomic, strong) KWSRegisterToken *registerToken;
@property (nonatomic, strong) KWSUnregisterToken *unregisterToken;
@property (nonatomic, strong) SystemCheckAllowed *checkSystem;
@property (nonatomic, strong) FirebaseGetToken *getToken;

// application reference
@property (nonatomic, weak) UIApplication *appRef;

@end

@implementation KWSNotificationProcess

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

- (void) register:(KWSChildrenRegisterForRemoteNotificationsBlock)reg {
    
    // make sure it won't cause any problems down the road
    __block KWSChildrenRegisterForRemoteNotificationsBlock registered = reg ? reg : ^(KWSChildrenRegisterForRemoteNotificationsStatus status){};
    
    [_checkSystem execute:^(BOOL allowed) {
        if (!allowed) {
            registered(KWSChildren_RegisterForRemoteNotifications_UserDisabledNotifications);
            return;
        }
        
        [_checkAllowed execute:^(BOOL allowed) {
            if (!allowed) {
                registered(KWSChildren_RegisterForRemoteNotifications_ParentDisabledNotifications);
                return;
            }
            
            [_requestPermission execute:@[@(KWSChildren_PermissionType_SendPushNotification)] :^(KWSChildrenRequestPermissionStatus status) {
                
                switch (status) {
                    // managed to request the Remote Notification permission
                    case KWSChildren_RequestPermission_Success: {
                        
                        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
                            UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
                            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
                            [_appRef registerUserNotificationSettings:settings];
                            [_appRef registerForRemoteNotifications];
                        } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
                            UIRemoteNotificationType allNotificationTypes = (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge);
                            [_appRef registerForRemoteNotificationTypes:allNotificationTypes];
#pragma GCC diagnostic pop
                        }
                        
                        // mark this
                        [_checkSystem markSystemDialogAsSeen];
                        
                        [_getToken execute:^(BOOL sucess, NSString *token) {
                            if (!sucess) {
                                registered(KWSChildren_RegisterForRemoteNotifications_FirebaseCouldNotGetToken);
                                return;
                            }
                            
                            [_registerToken execute:token :^(BOOL success) {
                                if (!success) {
                                    registered(KWSChildren_RegisterForRemoteNotifications_NetworkError);
                                } else {
                                    registered(KWSChildren_RegisterForRemoteNotifications_Success);
                                }
                            }];
                        }];
                        
                        break;
                    }
                    // No parent email available
                    case KWSChildren_RequestPermission_NoParentEmail: {
                        registered(KWSChildren_RegisterForRemoteNotifications_NoParentEmail);
                        break;
                    }
                    // A network error occurred
                    case KWSChildren_RequestPermission_NetworkError: {
                        registered(KWSChildren_RegisterForRemoteNotifications_NetworkError);
                        break;
                    }
                }
            }];
        }];
    }];
}

- (void) unregister:(KWSChildrenUnregisterForRemoteNotificationsBlock)unreg {
    // make sure thare are no problems here
    __block KWSChildrenUnregisterForRemoteNotificationsBlock unregistered = unreg ? unreg : ^(BOOL success){};
    NSString *token = [_getToken getSavedToken];
    
    // call func
    [_unregisterToken execute:token :^(BOOL success) {
        unregistered(success);
    }];
}

- (void) isRegistered:(KWSChildrenIsRegisteredForRemoteNotificationsInterface)isReg {
    // make sure no problems will appear
    __block KWSChildrenIsRegisteredForRemoteNotificationsInterface isRegistered = isReg ? isReg : ^(BOOL success){};
    
    // check
    [_checkSystem execute:^(BOOL allowed) {
        if (!allowed) {
            isRegistered(false);
            return;
        }
        
        [_checkAllowed execute:^(BOOL allowed) {
            if (!allowed) {
                isRegistered(false);
                return;
            }
            
            [_checkRegistered execute:^(BOOL registered) {
                isRegistered (registered);
            }];
        }];
    }];
}

@end
