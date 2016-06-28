//
//  KWS.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// imports
#import "KWSManager.h"
#import "PushManager.h"
#import "KWSParentEmail.h"

// forward declarations
@class KWSMetadata;

// Protocol

@protocol KWSProtocol <NSObject>

// potential public protocols
// kwsDidRegisterForRemoteNotification:(KWS*)sdk withToken:(NSString*)token
// kwsIsAllowedToRegisterForRemoteNotifications:(KWS*)sdk;
// kwsDidFailToRegisterForRemoteNotification:(KWS*)sdk;
//  - sdk.isPushEnabled()?
//  - sdk.isKWSAllowing()?
//  - sdk.isParentEmail()?
//  - sdk.isOtherError()?

- (void) isAllowedToRegisterForRemoteNotifications;
- (void) isAlreadyRegisteredForRemoteNotifications;
- (void) didRegisterForRemoteNotifications;
- (void) didFailBecauseKWSDoesNotAllowRemoteNotifications;
- (void) didFailBecauseKWSCouldNotFindParentEmail;
- (void) didFailBecauseRemoteNotificationsAreDisabled;
- (void) didFailBecauseParentEmailIsInvalid;
- (void) didFailBecauseOfError;
- (void) didFailBecauseFirebaseIsNotSetupCorrectly;

@end

// Class

@interface KWS : NSObject

// singleton func
+ (KWS*) sdk;

// setup func
- (void) setupWithOAuthToken:(NSString*)oauthToken kwsApiUrl:(NSString*)kwsApiUrl delegate:(id<KWSProtocol>)delegate;

// public funcs
- (void) checkIfNotificationsAreAllowed;
- (void) submitParentEmail:(NSString*)email;
- (void) registerForRemoteNotifications;

// getters
- (NSString*) getOAuthToken;
- (NSString*) getKWSApiUrl;
- (KWSMetadata*) getMetadata;
- (KWSMetadata*) getMetadata:(NSString*)oauthToken;

@end
