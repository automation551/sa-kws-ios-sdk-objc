//
//  KWS.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// get header
#import "KWS.h"

// get private imports
#import "KWSMetadata.h"
#import "SALogger.h"
#import "SAPopup.h"
#import "KWSLoggedUser.h"

@interface KWS ()

// the parent email object
@property (nonatomic, strong) KWSNotificationProcess *notificationProcess;
@property (nonatomic, strong) KWSCreateUserProcess *createUserProcess;
@property (nonatomic, strong) KWSParentEmail *parentEmail;
@property (nonatomic, strong) KWSGetUser *getUser;
@property (nonatomic, strong) KWSGetLeaderboard *getLeaderboard;
@property (nonatomic, strong) KWSRequestPermission *requestPermission;
@property (nonatomic, strong) KWSTriggerEvent *triggerEvent;
@property (nonatomic, strong) KWSGetScore *getScore;
@property (nonatomic, strong) KWSInviteUser *inviteUser;
@property (nonatomic, strong) KWSHasTriggeredEvent *hasTriggeredEvent;
@property (nonatomic, strong) KWSGetAppData *getAppData;
@property (nonatomic, strong) KWSSetAppData *setAppData;
@property (nonatomic, strong) KWSUpdateUser *updateUser;
@property (nonatomic, strong) KWSCreateUser *createUser;

// state properties
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSLoggedUser *loggedUser;

@end

@implementation KWS

+ (instancetype) sdk {
    static KWS *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id) init {
    if (self = [super init]) {
        _notificationProcess = [[KWSNotificationProcess alloc] init];
        _createUserProcess = [[KWSCreateUserProcess alloc] init];
        _parentEmail = [[KWSParentEmail alloc] init];
        _getUser = [[KWSGetUser alloc] init];
        _getLeaderboard = [[KWSGetLeaderboard alloc] init];
        _requestPermission = [[KWSRequestPermission alloc] init];
        _triggerEvent = [[KWSTriggerEvent alloc] init];
        _getScore = [[KWSGetScore alloc] init];
        _inviteUser = [[KWSInviteUser alloc] init];
        _hasTriggeredEvent = [[KWSHasTriggeredEvent alloc] init];
        _getAppData = [[KWSGetAppData alloc] init];
        _setAppData = [[KWSSetAppData alloc] init];
        _updateUser = [[KWSUpdateUser alloc] init];
        _createUser = [[KWSCreateUser alloc] init];
    }
    return self;
}

// MARK: Setup function

- (void) startSessionWithClientId:(NSString *)clientId
                  andClientSecret:(NSString *)clientSecret
                        andAPIUrl:(NSString *)apiUrl {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _kwsApiUrl = apiUrl;
}

- (void) stopSession {
    _loggedUser = nil;
    _kwsApiUrl = nil;
    _clientId = nil;
    _clientSecret = nil;
}

// Create, auth user

- (void) createUser:(NSString*)username
       withPassword:(NSString*)password
     andDateOfBirth:(NSString*)dateOfBirth
         andCountry:(NSString*)country
     andParentEmail:(NSString*)parentEmail
        andResponse:(userCreated)userCreated {
    [_createUserProcess createWithUsername:username
                               andPassword:password
                            andDateOfBirth:dateOfBirth
                                andCountry:country
                            andParentEmail:parentEmail
                                          :userCreated];
}

// get user & update user details

- (void) getUser:(gotUser)gotUser {
    [_getUser execute:gotUser];
}

- (void) updateUser:(KWSUser*)updatedUser
        andResponse:(updated)updated {
    [_updateUser execute:updatedUser
                        :updated];
}

// request permissions & submit parent email, if not already submitted

- (void) submitParentEmail:(NSString *)email
               andResponse:(submitted)submitted {
    [_parentEmail execute:email
                         :submitted];
}

- (void) requestPermission:(NSArray<NSNumber *> *)requestedPermissions
               andResponse:(requested)requested {
    [_requestPermission execute:requestedPermissions
                               :requested];
}

// invite another user

- (void) inviteUser:(NSString*)email
        andResponse:(invited)invited {
    [_inviteUser execute:email
                        :invited];
}

// events, points, leaderboards

- (void) triggerEvent:(NSString *)event
           withPoints:(NSInteger)points
          andResponse:(triggered)triggered {
    [_triggerEvent execute:event
                    points:points
                          :triggered];
}

- (void) hasTriggeredEvent:(NSInteger) eventId
               andResponse: (hasTriggered)triggered {
    [_hasTriggeredEvent execute:eventId
                               :triggered];
}

- (void) getScore:(gotScore)gotscore {
    [_getScore execute:gotscore];
}

- (void) getLeaderboard:(gotLeaderboard)gotLeaderboard {
    [_getLeaderboard execute:gotLeaderboard];
}

// app data

- (void) getAppData:(gotAppData)gotappdata {
    [_getAppData execute:gotappdata];
}

- (void) setAppData:(NSString*)name
          withValue:(NSInteger)value
        andResponse:(setAppData)setappdata {
    [_setAppData execute:name
               withValue:value
                        :setappdata];
}

// register for notifications

- (void) register:(registered)registered {
    [_notificationProcess register:registered];
}

- (void) unregister:(unregistered)unregistered {
    [_notificationProcess unregister:unregistered];
}

- (void) isRegistered:(isRegistered)isRegistered {
    [_notificationProcess isRegistered:isRegistered];
}

// MARK: public complex functions

- (void) registerWithPopup:(registered)registered {
    [[SAPopup sharedManager] showWithTitle:@"Hey!"
                                andMessage:@"Do you want to enable Remote Notifications?"
                                andOKTitle:@"Yes"
                               andNOKTitle:@"No"
                              andTextField:false
                           andKeyboardTyle:kNilOptions
                                andPressed:^(int button, NSString *popupMessage) {
                                    if (button == 0) {
                                        [_notificationProcess register:registered];
                                    } else {
                                        // do nothing
                                    }
                                }];
}

- (void) submitParentEmailWithPopup:(submitted)submitted {
    [[SAPopup sharedManager] showWithTitle:@"Hey!"
                                andMessage:@"To enable Remote Notifications in KWS you'll need to provide a parent email."
                                andOKTitle:@"Submit"
                               andNOKTitle:@"Cancel"
                              andTextField:true
                           andKeyboardTyle:UIKeyboardTypeEmailAddress
                                andPressed:^(int button, NSString *popupMessage) {
                                    if (button == 0) {
                                        [self submitParentEmail:popupMessage andResponse:submitted];
                                    }
                                }];
}

// MARK: version

- (NSString*) getVersion {
    return @"ios-2.0.16";
}

// MARK: setters & getters

- (void) setLoggedUser: (KWSLoggedUser*) loggedUser {
    _loggedUser = loggedUser;
}

- (KWSLoggedUser *) getLoggedUser {
    return _loggedUser;
}

- (NSString*) getClientId {
    return _clientId;
}

- (NSString*) getClientSecret {
    return _clientSecret;
}

- (NSString*) getKWSApiUrl {
    return _kwsApiUrl;
}

@end
