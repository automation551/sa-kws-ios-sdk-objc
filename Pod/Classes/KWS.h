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

/**
 Descriptor for the potential types of KWS errors
 */
typedef enum KWSErrorType {
    KWS_ParentHasDisabledRemoteNotifications = 0,
    System_UserHasDisabledRemoteNotifications = 1,
    KWS_UserHasNoParentEmail = 2,
    KWS_ParentEmailInvalid = 3,
    System_FirebaseNotSetup = 4,
    System_FirebaseCouldNotGetToken = 5,
    Network_ErrorCheckingIfUserHasRemoteNotificationsEnabledInKWS = 6,
    Network_ErrorRequestingRemoteNotificationsPermissionInKWS = 7,
    Network_ErrorSubmittingParentEmail = 8,
    Network_ErrorSubscribingTokenToKWS = 9,
    Network_ErrorUnsubscribingTokenFromKWS = 10
}KWSErrorType;

// Protocol
@protocol KWSProtocol <NSObject>

- (void) kwsSDKDidRegisterUserForRemoteNotifications;
- (void) kwsSDKDidUnregisterUserForRemoteNotifications;
- (void) kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType;

@end

// Class

@interface KWS : NSObject

// singleton func
+ (instancetype) sdk;

// setup func
- (void) setupWithOAuthToken:(NSString*)oauthToken
                   kwsApiUrl:(NSString*)kwsApiUrl
          andPermissionPopup:(BOOL)showPermissionPopup
                    delegate:(id<KWSProtocol>)delegate;

// public funcs
- (void) registerForRemoteNotifications;
- (void) unregisterForRemoteNotifications;
- (void) showParentEmailPopup;
- (void) submitParentEmail:(NSString*)email;

// getters
- (NSString*) getOAuthToken;
- (NSString*) getKWSApiUrl;
- (KWSMetadata*) getMetadata;

@end
