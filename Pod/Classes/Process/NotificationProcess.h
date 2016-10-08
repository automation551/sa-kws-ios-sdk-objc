//
//  NotificationProcess.h
//  Pods
//
//  Created by Gabriel Coman on 05/08/2016.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KWSErrorType) {
    ParentHasDisabledRemoteNotifications = 0,
    UserHasDisabledRemoteNotifications = 1,
    UserHasNoParentEmail = 2,
    FirebaseNotSetup = 3,
    FirebaseCouldNotGetToken = 4,
    FailedToCheckIfUserHasNotificationsEnabledInKWS = 5,
    FailedToRequestNotificationsPermissionInKWS = 6,
    FailedToSubscribeTokenToKWS = 7
};

// define blocks for the notification process
typedef void (^isRegistered)(BOOL success);
typedef void (^registered)(BOOL success, KWSErrorType type);
typedef void (^unregistered)(BOOL success);

@interface NotificationProcess : NSObject

- (void) register:(registered)registered;
- (void) unregister:(unregistered)unregistered;
- (void) isRegistered:(isRegistered)isRegistered;

@end
