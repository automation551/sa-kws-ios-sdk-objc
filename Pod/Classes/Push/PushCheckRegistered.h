//
//  PushRegisterPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module takes care of checking if a user is already registered for
//  Remote Notifications in the system
//
//  It also registeres Push notifications and unregisteres for Remote Notifications

#import <UIKit/UIKit.h>

// protocol
@protocol PushCheckRegisteredProtocol <NSObject>

- (void) isRegisteredInSystem;
- (void) isNotRegisteredInSystem;

@end

// class
@interface PushCheckRegistered : NSObject

// delegate
@property (nonatomic, weak) id<PushCheckRegisteredProtocol> delegate;

// main functions
- (void) isRegistered;

@end
