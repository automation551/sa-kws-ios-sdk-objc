//
//  KWSRequestPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module is concerned with send a request for a new permission to KWS,
//  namely for the Remote Notification permission
//
//  If all goes well the user is granted the new permission
//  If the user does not have a parent email, then that's an error case
//

#import <UIKit/UIKit.h>
#import "KWSService.h"

// enum to define permissions
typedef NS_ENUM(NSInteger, KWSChildrenPermissionType) {
    KWSChildren_PermissionType_AccessEmail             = 0,
    KWSChildren_PermissionType_AccessAddress           = 1,
    KWSChildren_PermissionType_AccessFirstName         = 2,
    KWSChildren_PermissionType_AccessLastName          = 3,
    KWSChildren_PermissionType_AccessPhoneNumber       = 4,
    KWSChildren_PermissionType_SendNewsletter          = 5,
    KWSChildren_PermissionType_SendPushNotification    = 6
};

// enum to define status
typedef NS_ENUM (NSInteger, KWSChildrenRequestPermissionStatus) {
    KWSChildren_RequestPermission_Success       = 0,
    KWSChildren_RequestPermission_NoParentEmail = 1,
    KWSChildren_RequestPermission_NetworkError  = 2
};

typedef void (^KWSChildrenRequestPermissionBlock)(KWSChildrenRequestPermissionStatus status);

@interface KWSRequestPermission : KWSService
- (void) execute:(NSArray<NSNumber*>*)requestPermissions
                :(KWSChildrenRequestPermissionBlock)requested;
@end
