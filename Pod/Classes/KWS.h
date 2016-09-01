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
#import "NotificationProcess.h"
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

// forward declarations
@class KWSMetadata;

@interface KWS : NSObject

// singleton func
+ (instancetype) sdk;

// setup func
- (void) setupWithOAuthToken:(NSString*)oauthToken
                   kwsApiUrl:(NSString*)kwsApiUrl;
- (void) desetup;

// Main public functions
- (void) register:(registered)registered;
- (void) unregister:(unregistered)unregistered;
- (void) isRegistered:(isRegistered)isRegistered;
- (void) submitParentEmail:(NSString*)email :(submitted)submitted;
- (void) getUser:(gotUser)gotUser;
- (void) getLeaderboard:(gotLeaderboard)gotLeaderboard;
- (void) requestPermission:(NSArray<NSNumber*>*)requestedPermissions :(requested)requested;
- (void) triggerEvent:(NSString*)event withPoints:(NSInteger)points andDescription:(NSString*)description :(triggered)triggered;
- (void) getScore:(gotScore)gotscore;
- (void) inviteUser:(NSString*)email :(invited)invited;
- (void) hasTriggeredEvent:(NSInteger) eventId : (hasTriggered)triggered;
- (void) getAppData:(gotAppData)gotappdata;
- (void) setAppData:(NSString*)name withValue:(NSInteger)value :(setAppData)setappdata;
- (void) updateUser:(KWSUser*)updatedUser :(updated)updated;

// Main aux public functions
- (void) registerWithPopup:(registered)registered;
- (void) submitParentEmailWithPopup:(submitted)submitted;

// getters
- (NSString*) getVersion;
- (NSString*) getOAuthToken;
- (NSString*) getKWSApiUrl;
- (KWSMetadata*) getMetadata;

@end
