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
    NoKWSPermission = 0,
    NoSystemPermission = 1,
    ParentEmailNotFound = 2,
    ParentEmailInvalid = 3,
    FirebaseNotSetup = 4,
    FirebaseCouldNotGetToken = 5,
    NetworkError_CheckKWSAllowsNotifications = 6,
    NetworkError_RequestPermissionFromKWS = 7,
    NetworkError_SubmitEmail = 8,
    NetworkError_SubscribeTokenToKWS = 9,
    NetworkError_UnsubscribeTokenToKWS = 10
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
