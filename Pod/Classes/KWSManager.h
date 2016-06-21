//
//  KWSManager.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// imports
#import "KWSCheckPermission.h"
#import "KWSRequestPermission.h"
#import "PushCheckPermission.h"
#import "PushRegisterPermission.h"

// protocol
@protocol KWSManagerProtocol <NSObject>

- (void) pushDisabledInSystem;
- (void) pushDisabledInKWS;
- (void) parentEmailIsMissingInKWS;
- (void) networkError;
- (void) isAllowedToRegister;
- (void) isAlreadyRegistered;

@end

// class
@interface KWSManager : NSObject <KWSCheckPermissionProtocol, KWSRequestPermissionProtocol, PushCheckPermissionProtocol, PushRegisterPermissionProtocol>

// singleton
+ (KWSManager*) sharedInstance;

// delegate
@property (nonatomic, weak) id<KWSManagerProtocol> delegate;

// public
- (void) checkIfNotificationsAreAllowed;

@end
