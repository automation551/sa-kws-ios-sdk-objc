//
//  PushCheckPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module just checks if Remote Notifications are enabled for a user
//  on the System.
//
//  If a user has explicitly disabled Remote Notifications (in the Settings
//  panel or otherwise), it will call pushDisabledInSytem
//
//  If a user has not disabled Remote Notifications, it will call
//  pushEnabledInSystem

#import <UIKit/UIKit.h>

// protocol
@protocol PushCheckAllowedProtocol <NSObject>

- (void) pushAllowedInSystem;
- (void) pushNotAllowedInSystem;

@end

// class
@interface PushCheckAllowed : NSObject

// delegate
@property (nonatomic, weak) id<PushCheckAllowedProtocol> delegate;

// main function
- (void) check;
- (void) markSystemDialogAsSeen;

@end
