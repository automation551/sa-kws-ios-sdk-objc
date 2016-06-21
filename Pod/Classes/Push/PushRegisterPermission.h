//
//  PushRegisterPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// protocol
@protocol PushRegisterPermissionProtocol <NSObject>

- (void) isRegisteredInSystem;
- (void) isNotRegisteredInSystem;

@end

// class
@interface PushRegisterPermission : NSObject

// delegate
@property (nonatomic, weak) id<PushRegisterPermissionProtocol> delegate;

// main functions
- (void) isRegistered;
- (void) registerPush;
- (void) unregisterPush;

@end
