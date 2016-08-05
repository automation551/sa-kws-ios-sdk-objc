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
#import "KWSRequest.h"

typedef NS_ENUM(NSInteger, KWSPermissionType) {
    accessEmail = 0,
    accessAddress = 1,
    accessFirstName = 2,
    accessLastName = 3,
    accessPhoneNumber = 4,
    sendNewsletter = 5,
    sendPushNotification = 6
};

// protocol
@protocol KWSRequestPermissionProtocol <NSObject>

- (void) pushPermissionRequestedInKWS;
- (void) parentEmailIsMissingInKWS;
- (void) permissionError;

@end

// callback
typedef void (^requested)(BOOL success, BOOL requested);

// class
@interface KWSRequestPermission : KWSRequest
// delegate
@property (nonatomic, weak) id<KWSRequestPermissionProtocol> delegate;

- (void) execute:(NSArray<NSNumber*>*)param :(requested)requested;
@end
