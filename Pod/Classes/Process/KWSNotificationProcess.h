//
//  NotificationProcess.h
//  Pods
//
//  Created by Gabriel Coman on 05/08/2016.
//
//

#import <Foundation/Foundation.h>

// notification status
typedef NS_ENUM(NSInteger, KWSChildrenRegisterForRemoteNotificationsStatus) {
    KWSChildren_RegisterForRemoteNotifications_Success                     = 0,
    KWSChildren_RegisterForRemoteNotifications_ParentDisabledNotifications = 1,
    KWSChildren_RegisterForRemoteNotifications_UserDisabledNotifications   = 2,
    KWSChildren_RegisterForRemoteNotifications_NoParentEmail               = 3,
    KWSChildren_RegisterForRemoteNotifications_FirebaseNotSetup            = 4,
    KWSChildren_RegisterForRemoteNotifications_FirebaseCouldNotGetToken    = 5,
    KWSChildren_RegisterForRemoteNotifications_NetworkError                = 6
};

// define blocks for the notification process
typedef void (^KWSChildrenIsRegisteredForRemoteNotificationsInterface)(BOOL success);
typedef void (^KWSChildrenRegisterForRemoteNotificationsBlock)(KWSChildrenRegisterForRemoteNotificationsStatus status);
typedef void (^KWSChildrenUnregisterForRemoteNotificationsBlock)(BOOL success);

@interface KWSNotificationProcess : NSObject

- (void) register:(KWSChildrenRegisterForRemoteNotificationsBlock)registered;
- (void) unregister:(KWSChildrenUnregisterForRemoteNotificationsBlock)unregistered;
- (void) isRegistered:(KWSChildrenIsRegisteredForRemoteNotificationsInterface)isRegistered;

@end
