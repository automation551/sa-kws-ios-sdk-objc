//
//  KWS.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// get header
#import "KWSChildren.h"

// get private imports
#import "KWSMetadata.h"
#import "SAAlert.h"
#import "KWSLoggedUser.h"

//to allow ObjC - Swift interoperability
#import "KWSiOSSDKObjC/KWSiOSSDKObjC-Swift.h"

#define LOGGED_USER_KEY @"KWS_SA_LOGGED_USER"

@interface KWSChildren ()

// the parent email object
@property (nonatomic, strong) KWSNotificationProcess *notificationProcess;
@property (nonatomic, strong) KWSCreateUserProcess *createUserProcess;
@property (nonatomic, strong) KWSAuthUserProcess *authUserProcess;
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
@property (nonatomic, strong) KWSRandomNameProcess *randomName;

// state properties
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *kwsApiUrl;

// instance of the logged user
@property (nonatomic, strong) KWSLoggedUser *loggedUser;

// user defaults
@property (nonatomic, strong) NSUserDefaults *defs;

//network environment
@property (weak, nonatomic) id <KWSNetworkEnvironment> kwsNetworkEnvironment;

@end

@implementation KWSChildren

+ (instancetype) sdk {
    static KWSChildren *sharedMyManager = nil;
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
        _authUserProcess = [[KWSAuthUserProcess alloc] init];
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
        _randomName = [[KWSRandomNameProcess alloc] init];
    }
    return self;
}

// MARK: Setup function

- (void) setupWithClientId:(NSString *)clientId
           andClientSecret:(NSString *)clientSecret
                 andAPIUrl:(NSString *)apiUrl {
    
    // set values
    _clientId = clientId;
    _clientSecret = clientSecret;
    _kwsApiUrl = apiUrl;
    
    //set network environment
    
    
    
    // get user defaults
    _defs = [NSUserDefaults standardUserDefaults];
    
    // try to see if there is a valid user in there
    if ([_defs objectForKey:LOGGED_USER_KEY]) {
        NSData *loggedIserData = [[NSUserDefaults standardUserDefaults] objectForKey:LOGGED_USER_KEY];
        KWSLoggedUser *tmpUser = [NSKeyedUnarchiver unarchiveObjectWithData:loggedIserData];
        if ([tmpUser isValid]) {
            _loggedUser = tmpUser;
            NSLog(@"KWS started with logged user %ld", (long)_loggedUser.metadata.userId);
            NSLog(@"Is user registered %d", _loggedUser.isRegisteredForNotifications);
        } else {
            NSLog(@"KWS started with a logged user that had an expired OAuth token. Clearning cache!");
            [_defs removeObjectForKey:LOGGED_USER_KEY];
            [_defs synchronize];
        }
    } else {
        NSLog(@"KWS started without a logged user since none was found");
    }
}

- (void) reset {
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
        andResponse:(KWSChildrenCreateUserBlock)response {
    [_createUserProcess createWithUsername:username
                               andPassword:password
                            andDateOfBirth:dateOfBirth
                                andCountry:country
                            andParentEmail:parentEmail
                                          :response];
}


//SA Test
- (void) loginUser:(NSString *)username
      withPassword:(NSString *)password
       andResponse:(KWSChildrenLoginUserBlock)response {
    
    //this is the real deal
    //    [_authUserProcess authWithUsername:username
    //                           andPassword:password
    //                                      :response];
    //end of real deal
    //-------------------------------------//
    
    
    
    //this is a test
    
    KWSSDK *kwsSDK = [KWSSDK sharedInstance];
    
//    LoginService *logServ = [kwsSDK getLoginProviderWithEnvironment:(id<KWSNetworkEnvironment> _Nonnull) networkTask:(NetworkTask * _Nonnull)]
    
    
    
    //end of test
    
}

- (void) authWithSingleSignOnUrl: (NSString*) url
                      fromParent: (UIViewController*)parent
                     andResponse:(KWSChildrenLoginUserBlock) response {
    [_authUserProcess authWithSingleSignOnUrl:url
                                   fromParent:parent
                                             :response];
    
}

- (void) openUrl: (NSURL*) url
     withOptions: (NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    [_authUserProcess openUrl:url withOptions:options];
}

- (void) logoutUser {
    _loggedUser = nil;
    _defs = [NSUserDefaults standardUserDefaults];
    if ([_defs objectForKey:LOGGED_USER_KEY]) {
        [_defs removeObjectForKey:LOGGED_USER_KEY];
        [_defs synchronize];
    }
}

// Random name

- (void) getRandomUsername:(KWSChildrenGetRandomUsernameBlock)response {
    //this is the correct one
    [_randomName getRandomName:response];
    
    //this is a test
    //    [self getTestSingleton];
    
}

// get user & update user details

- (void) getUser:(KWSChildrenGetUserBlock)response {
    [_getUser execute:response];
}

- (void) updateUser:(KWSUser*)updatedUser
       withResponse:(KWSChildrenUpdateUserBlock)response {
    [_updateUser execute:updatedUser :response];
}

// request permissions & submit parent email, if not already submitted

- (void) updateParentEmail:(NSString *)email
              withResponse:(KWSChildrenUpdateParentEmailBlock)response {
    [_parentEmail execute:email :response];
}

- (void) requestPermission:(NSArray<NSNumber *> *)requestedPermissions
              withResponse:(KWSChildrenRequestPermissionBlock)response {
    [_requestPermission execute:requestedPermissions
                               :response];
}

// invite another user

- (void) inviteUser:(NSString*)email
       withResponse:(KWSChildrenInviteUserBlock)response {
    [_inviteUser execute:email
                        :response];
}

// events, points, leaderboards

- (void) triggerEvent:(NSString *)event
           withPoints:(NSInteger)points
          andResponse:(KWSChildrenTriggerEventBlock)response {
    [_triggerEvent execute:event
                    points:points
                          :response];
}

- (void) hasTriggeredEvent:(NSInteger) eventId
              withResponse: (KWSChildrenHasTriggeredEventBlock)response {
    [_hasTriggeredEvent execute:eventId
                               :response];
}

- (void) getScore:(KWSChildrenGetScoreBlock)response {
    [_getScore execute:response];
}

- (void) getLeaderboard:(KWSChildrenGetLeaderboardBlock)response {
    [_getLeaderboard execute:response];
}

// app data

- (void) getAppData:(KWSChildrenGetAppDataBlock)response {
    [_getAppData execute:response];
}

- (void) setAppData:(NSInteger)value
            forName:(NSString*)name
        andResponse:(KWSChildrenSetAppDataBlock)response {
    [_setAppData execute:name withValue:value :response];
}

// register for notifications

- (void) registerForRemoteNotifications:(KWSChildrenRegisterForRemoteNotificationsBlock)response {
    [_notificationProcess register:^(KWSChildrenRegisterForRemoteNotificationsStatus status) {
        if (status == KWSChildren_RegisterForRemoteNotifications_Success && _loggedUser) {
            [_loggedUser setIsRegisteredForNotifications:true];
            // [self setLoggedUser:_loggedUser]; @todo: this acts buggy
        }
        if (response != nil) {
            response(status);
        }
    }];
}

- (void) unregisterForRemoteNotifications:(KWSChildrenUnregisterForRemoteNotificationsBlock)response {
    [_notificationProcess unregister:^(BOOL success) {
        if (success && _loggedUser != nil) {
            [_loggedUser setIsRegisteredForNotifications:false];
            // [self setLoggedUser:_loggedUser]; @todo: this acts buggy
        }
        if (response != nil) {
            response (success);
        }
    }];
}

- (void) isRegisteredForRemoteNotifications:(KWSChildrenIsRegisteredForRemoteNotificationsInterface)response {
    [_notificationProcess isRegistered:^(BOOL success) {
        if (response) {
            response(success);
        }
    }];
}

// MARK: public complex functions

- (void) registerForRemoteNotificationsWithPopup:(KWSChildrenRegisterForRemoteNotificationsBlock)response {
    [[SAAlert getInstance] showWithTitle:@"Hey!"
                              andMessage:@"Do you want to enable Remote Notifications?"
                              andOKTitle:@"Yes"
                             andNOKTitle:@"No"
                            andTextField:false
                         andKeyboardTyle:kNilOptions
                              andPressed:^(int button, NSString *popupMessage) {
                                  if (button == 0) {
                                      [_notificationProcess register:response];
                                  } else {
                                      // do nothing
                                  }
                              }];
}

- (void) updateParentEmailWithPopup:(KWSChildrenUpdateParentEmailBlock)response {
    [[SAAlert getInstance] showWithTitle:@"Hey!"
                              andMessage:@"To enable Remote Notifications in KWS you'll need to provide a parent email."
                              andOKTitle:@"Submit"
                             andNOKTitle:@"Cancel"
                            andTextField:true
                         andKeyboardTyle:UIKeyboardTypeEmailAddress
                              andPressed:^(int button, NSString *popupMessage) {
                                  if (button == 0) {
                                      [self updateParentEmail:popupMessage withResponse:response];
                                  }
                              }];
}

// MARK: version

- (NSString*) getVersion {
    return @"ios-2.3.2";
}

// MARK: setters & getters

- (void) setLoggedUser: (KWSLoggedUser*) loggedUser {
    // assign new logged user
    _loggedUser = loggedUser;
    
    // save logged user to defaults
    NSData *loggedUserData = [NSKeyedArchiver archivedDataWithRootObject:_loggedUser];
    [_defs setObject:loggedUserData forKey:LOGGED_USER_KEY];
    [_defs synchronize];
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



-(void) getTestSingleton{
    
    //    KWSSDK *sdk = [KWSSDK sharedInstance];
    //    NSString *testing = [sdk testKWSSDK];
    //    NSLog(@"Testing---> %@",testing);
    
}

@end
