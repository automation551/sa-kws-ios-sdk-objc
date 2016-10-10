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
#import "CreateUserProcess.h"
#import "NotificationProcess.h"

// forward declarations
@class KWSMetadata;

@interface KWS : NSObject

// singleton func
+ (instancetype) sdk;

// setup func
- (void) startSessionWithClientId:(NSString*)clientId
                  andClientSecret:(NSString*)clientSecret
                        andAPIUrl:(NSString*)apiUrl;
- (void) stopSession;

// Main public functions
- (void) register:(registered)registered;
- (void) unregister:(unregistered)unregistered;
- (void) isRegistered:(isRegistered)isRegistered;
- (void) submitParentEmail:(NSString*)email :(submitted)submitted;
- (void) createUser:(NSString*)username withPassword:(NSString*)password andDateOfBirth:(NSString*)dateOfBirth andCountry:(NSString*)country andParentEmail:(NSString*)parentEmail :(userCreated) userCreated;
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

// version
- (NSString*) getVersion;

// other setters & getters
- (NSString*) getClientId;
- (NSString*) getClientSecret;
- (NSString*) getKWSApiUrl;
- (void) setLoggedUser: (KWSLoggedUser*) loggedUser;
- (KWSLoggedUser*) getLoggedUser;

@end
