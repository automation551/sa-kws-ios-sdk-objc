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

// protocol
@protocol KWSManagerProtocol <NSObject>

- (void) pushNotAllowedInSystem;
- (void) pushNotAllowedInKWS;
- (void) parentEmailIsMissingInKWS;
- (void) isAllowedToRegister;
- (void) networkErrorCheckingInKWS;
- (void) networkErrorRequestingPermissionFromKWS;

@end

// class
@interface KWSManager : NSObject <KWSCheckAllowedProtocol, KWSRequestPermissionProtocol, PushCheckAllowedProtocol/*, PushCheckRegisteredProtocol*/>

// singleton
+ (instancetype) sharedInstance;

// delegate
@property (nonatomic, weak) id<KWSManagerProtocol> delegate;

// public
- (void) checkIfNotificationsAreAllowed;

@end