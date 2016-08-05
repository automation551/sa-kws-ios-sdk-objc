//
//  KWSErrorType.h
//  Pods
//
//  Created by Gabriel Coman on 05/08/2016.
//
//

#import <Foundation/Foundation.h>

/**
 Descriptor for the potential types of KWS errors
 */
typedef NS_ENUM(NSInteger, KWSErrorType) {
    ParentHasDisabledRemoteNotifications = 0,
    UserHasDisabledRemoteNotifications = 1,
    UserHasNoParentEmail = 2,
    ParentEmailInvalid = 3,
    FirebaseNotSetup = 4,
    FirebaseCouldNotGetToken = 5,
    FailedToCheckIfUserHasNotificationsEnabledInKWS = 6,
    FailedToRequestNotificationsPermissionInKWS = 7,
    FailedToSubmitParentEmail = 8,
    FailedToSubscribeTokenToKWS = 9
};