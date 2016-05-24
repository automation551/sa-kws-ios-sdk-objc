//
//  PushManager.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

#import "PushCheckPermission.h"
#import "PushRegisterPermission.h"

// protocol
@protocol PushManagerProtocol <NSObject>

- (void) didRegister;
- (void) didNotRegister;

@end

// class
@interface PushManager : NSObject <UIApplicationDelegate, PushCheckPermissionProtocol>

// singleton
+ (PushManager*) sharedInstance;

// delegate
@property (nonatomic, weak) id<PushManagerProtocol> delegate;

// main public funciton
- (void) registerForPushNotifications;

@end
