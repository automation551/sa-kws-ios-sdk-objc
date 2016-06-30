//
//  KWSCheckPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module handles checking for Remote Notification
//  permissions from the KWS backend.
//  It calls the back-end to get a user profile and associated permissions.
//
//  Push Notifications are enabled if the permissions value is either NULL or true
//  They are disabled if false
//

#import <UIKit/UIKit.h>

// protocol
@protocol KWSCheckAllowedProtocol <NSObject>

- (void) pushAllowedInKWS;
- (void) pushNotAllowedInKWS;
- (void) checkError;

@end

// class
@interface KWSCheckAllowed : NSObject

// delegate
@property (nonatomic, weak) id<KWSCheckAllowedProtocol> delegate;

/**
 *  Main object fucntion
 */
- (void) check;

@end
