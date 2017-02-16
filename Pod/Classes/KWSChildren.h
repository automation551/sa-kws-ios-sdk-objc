//
//  KWS.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// imports
#import "KWSParentEmail.h"
#import "KWSGetUser.h"
#import "KWSGetLeaderboard.h"
#import "KWSRequestPermission.h"
#import "KWSTriggerEvent.h"
#import "KWSParentEmail.h"
#import "KWSGetScore.h"
#import "KWSGetAppData.h"
#import "KWSSetAppData.h"
#import "KWSHasTriggeredEvent.h"
#import "KWSUpdateUser.h"
#import "KWSInviteUser.h"
#import "KWSCreateUser.h"
#import "KWSLoggedUser.h"
#import "KWSCreateUserProcess.h"
#import "KWSNotificationProcess.h"
#import "KWSAuthUserProcess.h"
#import "KWSRandomNameProcess.h"

// forward declarations
@class KWSMetadata;

@interface KWSChildren : NSObject

// singleton func
+ (instancetype) sdk;

// setup func
- (void) setupWithClientId:(NSString*)clientId
           andClientSecret:(NSString*)clientSecret
                 andAPIUrl:(NSString*)apiUrl;
- (void) reset;

// Create, auth user
- (void) createUser:(NSString*)username
       withPassword:(NSString*)password
     andDateOfBirth:(NSString*)dateOfBirth
         andCountry:(NSString*)country
     andParentEmail:(NSString*)parentEmail
        andResponse:(KWSChildrenCreateUserBlock) response;

- (void) loginUser:(NSString*)username
      withPassword:(NSString*)password
       andResponse:(KWSChildrenLoginUserBlock) response;

- (void) logoutUser;

// random name
- (void) getRandomUsername:(KWSChildrenGetRandomUsernameBlock)response;

// get user & update user details
- (void) getUser:(KWSChildrenGetUserBlock)response;
- (void) updateUser:(KWSUser*)updatedUser
       withResponse:(KWSChildrenUpdateUserBlock)response;

// request permissions & submit parent email, if not already submitted
- (void) updateParentEmail:(NSString*)email
              withResponse:(KWSChildrenUpdateParentEmailBlock)response;
- (void) requestPermission:(NSArray<NSNumber*>*)requestedPermissions
              withResponse:(KWSChildrenRequestPermissionBlock)response;

// invite another user
- (void) inviteUser:(NSString*)email
       withResponse:(KWSChildrenInviteUserBlock)response;

// events, points, leaderboards
- (void) triggerEvent:(NSString*)event
           withPoints:(NSInteger)points
          andResponse:(KWSChildrenTriggerEventBlock)response;
- (void) hasTriggeredEvent:(NSInteger) eventId
              withResponse: (KWSChildrenHasTriggeredEventBlock)response;
- (void) getScore:(KWSChildrenGetScoreBlock)response;
- (void) getLeaderboard:(KWSChildrenGetLeaderboardBlock)response;

// app data
- (void) getAppData:(KWSChildrenGetAppDataBlock)response;
- (void) setAppData:(NSInteger)value
            forName:(NSString*)name
        andResponse:(KWSChildrenSetAppDataBlock)response;

// register for notifications
- (void) registerForRemoteNotifications:(KWSChildrenRegisterForRemoteNotificationsBlock)response;
- (void) unregisterForRemoteNotifications:(KWSChildrenUnregisterForRemoteNotificationsBlock)response;
- (void) isRegisteredForRemoteNotifications:(KWSChildrenIsRegisteredForRemoteNotificationsInterface)response;

// Main aux public functions
- (void) registerForRemoteNotificationsWithPopup:(KWSChildrenRegisterForRemoteNotificationsBlock)response;
- (void) updateParentEmailWithPopup:(KWSChildrenUpdateParentEmailBlock)response;

// version
- (NSString*) getVersion;

// other setters & getters
- (NSString*) getClientId;
- (NSString*) getClientSecret;
- (NSString*) getKWSApiUrl;
- (void) setLoggedUser: (KWSLoggedUser*) loggedUser;
- (KWSLoggedUser*) getLoggedUser;

@end
