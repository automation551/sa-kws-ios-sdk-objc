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
#import "CheckManager.h"
#import "KWSParentEmail.h"

// forward declarations
@class KWSMetadata;

/**
 Descriptor for the potential types of KWS errors
 */
typedef NS_ENUM(NSInteger, KWSErrorType) {
    ParentHasDisabledRemoteNotifications = 0,
    UserHasDisabledRemoteNotifications = 1,
    UserHasNoParentEmail = 2,
    ParentEmailInvalid = 3,
    FirebaseNotSetup = 4,
    FirebaseCouldNotGetToken = 5,
    FailedToCheckIfUserHasNotificationsEnabledInKWS = 6,
    FailedToRequestNotificationsPermissionInKWS = 7,
    FailedToSubmitParentEmail = 8,
    FailedToSubscribeTokenToKWS = 9
};

// Protocols
@protocol KWSRegisterProtocol <NSObject>
- (void) kwsSDKDidRegisterUserForRemoteNotifications;
- (void) kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType;
@end

@protocol KWSUnregisterProtocol <NSObject>
- (void) kwsSDKDidUnregisterUserForRemoteNotifications;
- (void) kwsSDKDidFailToUnregisterUserForRemoteNotifications;
@end

@protocol KWSCheckProtocol <NSObject>
- (void) kwsSDKUserIsRegistered;
- (void) kwsSDKUserIsNotRegistered;
- (void) kwsSDKDidFailToCheckIfUserIsRegistered;
@end

// Class

@interface KWS : NSObject

// singleton func
+ (instancetype) sdk;

// setup func
- (void) setupWithOAuthToken:(NSString*)oauthToken
                   kwsApiUrl:(NSString*)kwsApiUrl
          andPermissionPopup:(BOOL)showPermissionPopup;

// Main public functions
- (void) registerForRemoteNotifications:(id<KWSRegisterProtocol>)delegate;
- (void) unregisterForRemoteNotifications:(id<KWSUnregisterProtocol>)delegate;
- (void) userIsRegistered:(id<KWSCheckProtocol>)delegate;
//- (void) getUserProfile;

// Main aux public functions
- (void) showParentEmailPopup;
- (void) submitParentEmail:(NSString*)email;

// getters
- (NSString*) getVersion;
- (NSString*) getOAuthToken;
- (NSString*) getKWSApiUrl;
- (KWSMetadata*) getMetadata;

@end
