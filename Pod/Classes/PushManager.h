//
//  PushManager.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

#import "PushCheckAllowed.h"
#import "PushCheckRegistered.h"
#import "PushRegister.h"

// protocol
@protocol PushManagerProtocol <NSObject>

- (void) didRegisterWithSystem:(NSString*)token;
- (void) didNotRegister;
- (void) didUnregisterWithSystem;

@end

// class
@interface PushManager : NSObject <UIApplicationDelegate, PushCheckAllowedProtocol>

// singleton
+ (PushManager*) sharedInstance;

// delegate
@property (nonatomic, weak) id<PushManagerProtocol> delegate;

// main public functions
- (void) registerForPushNotifications;
- (void) unregisterForPushNotifications;

@end
