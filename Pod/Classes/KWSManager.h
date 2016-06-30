//
//  KWSManager.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// imports
#import "KWSCheckAllowed.h"
#import "KWSRequestPermission.h"
#import "PushCheckAllowed.h"
#import "PushCheckRegistered.h"
#import "PushRegister.h"

// protocol
@protocol KWSManagerProtocol <NSObject>

- (void) pushNotAllowedInSystem;
- (void) pushNotAllowedInKWS;
- (void) parentEmailIsMissingInKWS;
- (void) networkError;
- (void) isAllowedToRegister;
- (void) isAlreadyRegistered;

@end

// class
@interface KWSManager : NSObject <KWSCheckAllowedProtocol, KWSRequestPermissionProtocol, PushCheckAllowedProtocol, PushCheckRegisteredProtocol>

// singleton
+ (KWSManager*) sharedInstance;

// delegate
@property (nonatomic, weak) id<KWSManagerProtocol> delegate;

// public
- (void) checkIfNotificationsAreAllowed;

@end
