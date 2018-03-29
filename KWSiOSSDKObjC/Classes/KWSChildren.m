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
#import "SAUtils.h"

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
    @property (nonatomic, strong) UserKWSNetworkEnvironment* userKWSNetworkEnvironment;
    
#define kProviderErrorMessage @"An error occured getting the provider!"
#define kNoValidLoggedInUserMessage @"No valid logged in user."
#define kNoValidUserDetailsMessage @"No valid user details..."
#define kNoValidPermissionsMessage @"No valid permissions!"
    
    
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
    _userKWSNetworkEnvironment = [[UserKWSNetworkEnvironment alloc] initWithDomain:apiUrl appID:clientSecret mobileKey:clientId];
    
    
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
        NSLog(kProviderErrorMessage);
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
    
    
    AuthProvider* authProvider =[[KWSSDK sharedInstance]
                                             getProviderWithEnvironment:_userKWSNetworkEnvironment
                                             type:NSStringFromClass([AuthProvider class])];
    
//    authProvider create
    
    
    if ([authProvider isKindOfClass: [AuthProvider class]]){
        
        [authProvider createUserWithUsername:username password:password dateOfBirth:dateOfBirth country:country parentEmail:parentEmail callback:^(KWSCreateUserResponse * createUserResponse, NSError * error) {
            
            if(createUserResponse != nil && [createUserResponse token] != nil ){
                
                NSString* token = [createUserResponse token];
                KWSMetadata *kwsMetadata = [self getMetadataFromToken:token];
                
                KWSLoggedUser *loggedUser = [[KWSLoggedUser alloc]initWithToken:token andMetadata:kwsMetadata];
                [self setLoggedUser:loggedUser];
                
                
                response(KWSChildren_CreateUser_Success);
            }else{
                response(KWSChildren_CreateUser_InvalidOperation);
            }
        }];
        
    }else{
        NSLog(kProviderErrorMessage);
    }
    
    
}
    
- (void) loginUser:(NSString *)username
      withPassword:(NSString *)password
       andResponse:(KWSChildrenLoginUserBlock)response {
    
    AuthProvider* authProvider = [[KWSSDK sharedInstance] getProviderWithEnvironment:_userKWSNetworkEnvironment
                                                                                  type:NSStringFromClass([AuthProvider class])];
    
    if ([authProvider isKindOfClass: [AuthProvider class]]){
        
        [authProvider loginUserWithUsername:username password:password callback:^(KWSLoginResponse *loginResponse, NSError *error) {
            
            if(loginResponse != nil && [loginResponse token] != nil
               && [[loginResponse token] length] != 0 && error == nil){
                
                NSString* token = [loginResponse token];
                KWSMetadata *kwsMetadata = [self getMetadataFromToken:token];
                
                KWSLoggedUser *loggedUser = [[KWSLoggedUser alloc]initWithToken:token andMetadata:kwsMetadata];
                [self setLoggedUser:loggedUser];
                
                response (KWSChildren_LoginUser_Success);
            }else{
                response (KWSChildren_LoginUser_NetworkError);
            }
            
        }];
    } else {
        NSLog(kProviderErrorMessage);
    }
}
    
    //------METADATA NEW LOGIC--------
    
-(KWSMetadata*) getMetadataFromToken : (NSString*) token {
    //todo here
    MetadataKWS* metadataNewObject = [[UtilsHelpers sharedInstance] getTokenDataWithToken : token];
    
    KWSMetadata* kwsMetadata = [[KWSMetadata alloc]initWithUserId:metadataNewObject.userId andAppId:metadataNewObject.appId andClientId:metadataNewObject.clientId andScope:metadataNewObject.scope andIat:metadataNewObject.iat andExp:metadataNewObject.exp andIss:metadataNewObject.iss];
    
    return kwsMetadata;
    
}
    
    //------END METADATA NEW LOGIC------
    
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
    
    UsernameProvider* usernameProvider = [[KWSSDK sharedInstance] getProviderWithEnvironment:_userKWSNetworkEnvironment
                                                                                                    type:NSStringFromClass([UsernameProvider class])];
    
    if ([usernameProvider isKindOfClass: [UsernameProvider class]]){
        
        [usernameProvider getRandomUsernameWithCallback:^(KWSRandomUsernameResponse *randomUsernameResponse, NSError * error) {
            
            if(randomUsernameResponse != nil && [randomUsernameResponse randomUsername] != nil && [[randomUsernameResponse randomUsername]length] != 0 && error == nil){
                response ([randomUsernameResponse randomUsername]);
            }else{
                response (nil);
            }
            
        }];
    } else {
        NSLog(kProviderErrorMessage);
    }
    
    
    
}
    
    // get user & update user details
    
- (void) getUser:(KWSChildrenGetUserBlock)response {
    
    UserProvider* userProvider = [[KWSSDK sharedInstance]
                                  getProviderWithEnvironment:_userKWSNetworkEnvironment
                                  type:NSStringFromClass([UserProvider class])];
    
    if ([userProvider isKindOfClass: [UserProvider class]]){
        
        if(_loggedUser == nil || _loggedUser.metadata == nil){
            response(nil);
            NSLog(kNoValidLoggedInUserMessage);
            return;
        }
        
        [userProvider getUserDetailsWithUserId: (long)_loggedUser.metadata.userId
                                         token: _loggedUser.token
                                      callback:^(KWSUserDetails * userDetails, NSError * error) {
                                          
                                          
                                          if(userDetails != nil){
                                              KWSUser *kwsUser = [self buildKWSUser:userDetails];
                                              response(kwsUser);
                                          }else{
                                              response(nil);
                                          }
                                          
                                          
                                          
                                      }];
    } else {
        NSLog(kProviderErrorMessage);
    }
    
}
    
    //---------------------Helper methods to build KWSUser---------------------//
    
- (KWSUser*) buildKWSUser:(KWSUserDetails*) kwsUserDetailsResponse {
    
    NSNumber *id = [kwsUserDetailsResponse id];
    NSString *username = [kwsUserDetailsResponse username];
    NSString *firstName = [kwsUserDetailsResponse firstName];
    NSString *lastName = [kwsUserDetailsResponse lastName];
    NSString *dateOfBirth = [kwsUserDetailsResponse dateOfBirth];
    NSString *gender = [kwsUserDetailsResponse gender];
    NSString *language = [kwsUserDetailsResponse language];
    NSString *email = [kwsUserDetailsResponse email];
    NSString *parentEmail = [kwsUserDetailsResponse parentEmail];
    
    KWSAddress *address = [self buildKWSUserAddress: [kwsUserDetailsResponse address]];
    KWSPoints *points = [self buildKWSPoints: [kwsUserDetailsResponse points]];
    KWSPermissions *permissions = [self buildKWSPermissions: [kwsUserDetailsResponse applicationPermissions]];
    KWSApplicationProfile *appProfile = [self buildKWSApplicationProfile: [kwsUserDetailsResponse applicationProfile]];
    
    
    KWSUser * user = [[KWSUser alloc]initWithID:id andUsername:username andFirstName:firstName andLastName:lastName andDateOfBirth:dateOfBirth andGender:gender andLanguage:language andEmail:email andAddress:address andPoints:points andAppPermissions:permissions andAppProfile:appProfile andParentEmail:parentEmail];
    
    return user;
    
}
    
- (KWSAddress*) buildKWSUserAddress:(KWSSwiftUserAddress*) address{
    
    NSString * street = [address street];
    NSString * city = [address city];
    NSString * postCode = [address postCode];
    NSString * country = [address country];
    
    return [[KWSAddress alloc] initWithStreet: street
                                      andCity:city
                                  andPostCode:postCode
                                   andCountry:country];
}
    
- (KWSPoints*) buildKWSPoints:(KWSSwiftPoints*) points{
    
    
    NSInteger totalReceived = [points received];
    NSInteger total = [points total];
    NSInteger totalPointsReceivedInCurrentApp = [points inApp];
    NSInteger availableBalance = [points balance];
    NSInteger pending = [points pending];
    
    return [[KWSPoints alloc] initWithTotalReceived:totalReceived
                                           andTotal:total
                 andTotalPointsReceivedInCurrentApp:totalPointsReceivedInCurrentApp
                                andAvailableBalance:availableBalance
                                         andPending:pending];
}
    
- (KWSPermissions*) buildKWSPermissions:(KWSSwiftApplicationPermissions*) permissions{
    
    NSNumber * accessAddress = [permissions address];
    NSNumber * accessFirstName = [permissions firstName];
    NSNumber * accessLastName = [permissions lastName];
    NSNumber * accessEmail = [permissions email];
    NSNumber * accessStreetAddress = [permissions street];
    NSNumber * accessCity = [permissions city];
    NSNumber * accessPostalCode = [permissions postalCode];
    NSNumber * accessCountry = [permissions country];
    NSNumber * sendPushNotification = [permissions notifications];
    NSNumber * sendNewsletter = [permissions newsletter];
    NSNumber * enterCompetitions = [permissions competition];
    
    
    return [[KWSPermissions alloc] initWithAccessAddress:accessAddress andAccessFirstName:accessFirstName andAccessLastName:accessLastName andAccessEmail:accessEmail andAccessStreetAddress:accessStreetAddress andAccessCity:accessCity andAccessPostalCode:accessPostalCode andAccessCountry:accessCountry andSendPushNotification:sendPushNotification andSendNewsletter:sendNewsletter andEnterCompetitions:enterCompetitions];
}
    
- (KWSApplicationProfile*) buildKWSApplicationProfile:(KWSSwiftApplicationProfile*) appProfile{
    
    NSString * username = [appProfile name];
    NSNumber * customField1 = [appProfile customField1];
    NSNumber * customField2 = [appProfile customField2];
    NSNumber * avatarId = [appProfile avatarId];
    
    return [[KWSApplicationProfile alloc] initWithUsername: username andCustomField1: customField1 andCustomField2: customField2 andAvatarId: avatarId];
}
    //---------------------end helper method for KWSUser---------------------//
    
    
    
    
- (void) updateUser:(KWSUser*)updatedUser
       withResponse:(KWSChildrenUpdateUserBlock)response {
    
    UserProvider* userProvider = [[KWSSDK sharedInstance]
                                  getProviderWithEnvironment:_userKWSNetworkEnvironment
                                  type:NSStringFromClass([UserProvider class])];
    
    if ([userProvider isKindOfClass: [UserProvider class]]){
        
        
        if(_loggedUser == nil || _loggedUser.metadata == nil ){
            response(false);
            NSLog(kNoValidLoggedInUserMessage);
            return;
        }
        
        //KWSUser into UserDetails here
        KWSUserDetails *userDetails = [self buildUserDetails: updatedUser];
        if(userDetails == nil){
            response(false);
            NSLog(kNoValidUserDetailsMessage);
        }
        
        [userProvider updateUserDetailsWithUserId:(long)_loggedUser.metadata.userId
                                            token: _loggedUser.token
                                      userDetails:userDetails
                                         callback:^(BOOL success, NSError * error) {
                                             //
                                             //callback here
                                             if(success){
                                                 NSLog(@"Success updating user!");
                                             }else{
                                                 NSLog(@"Failed to update user...");
                                             }
                                             response(success);
                                             
                                         }];
    } else {
        NSLog(kProviderErrorMessage);
    }
    
    
}
    
    //---------------------Helper methods for User Details---------------------//
-(KWSUserDetails*) buildUserDetails: (KWSUser*) updateUser {
    
    KWSSwiftUserAddress * kwsSwiftUserAddress = [self buildSwiftUserAddress: [updateUser address] ];
    KWSSwiftApplicationProfile * kwsSwiftAppProfile = [self buildSwiftAppProfile: [updateUser applicationProfile]];
    
    return [[KWSUserDetails alloc] initWithId:nil
                                     username:nil
                                    firstName:updateUser.firstName
                                     lastName:updateUser.lastName
                                      address:kwsSwiftUserAddress
                                  dateOfBirth:updateUser.dateOfBirth
                                       gender:updateUser.gender
                                     language:updateUser.language
                                        email:updateUser.email
                                  phoneNumber:updateUser.phoneNumber
                            hasSetParentEmail:nil
                           applicationProfile:kwsSwiftAppProfile
                       applicationPermissions:nil
                                       points:nil
                                    createdAt:nil
                                  parentEmail:updateUser.parentEmail];
    
}
    
    
    //-----------------//
    
    
-(KWSSwiftUserAddress*) buildSwiftUserAddress:(KWSAddress*) address {
    
    //parse country
    NSString* parsedCountry = [[UtilsHelpers sharedInstance] getUserDetailsCountryCodeWithCountry:address.country];
    
    return [[KWSSwiftUserAddress alloc] initWithStreet:address.street city:address.city postCode:address.postCode country:parsedCountry ];
    
}
    
    
-(KWSSwiftApplicationProfile*) buildSwiftAppProfile:(KWSApplicationProfile*) profile {
    
    NSNumber* customField1 = [NSNumber numberWithInteger:profile.customField1];
    NSNumber* customField2 = [NSNumber numberWithInteger:profile.customField2];
    NSNumber* avatarId = [NSNumber numberWithInteger:profile.customField1];
    
    
    return [[KWSSwiftApplicationProfile alloc] initWithUsername:nil
                                                   customField1:customField1
                                                   customField2:customField2
                                                       avatarId:avatarId];
    
    
}
    
    
    
    
    //---------------------end helper method for User details---------------------//
    
    // request permissions & submit parent email, if not already submitted
    
- (void) updateParentEmail:(NSString *)email
              withResponse:(KWSChildrenUpdateParentEmailBlock)response {
    
    
    UserProvider* userProvider = [[KWSSDK sharedInstance]
                                  getProviderWithEnvironment:_userKWSNetworkEnvironment
                                  type:NSStringFromClass([UserProvider class])];
    
    if ([userProvider isKindOfClass: [UserProvider class]]){
        
        if(_loggedUser == nil || _loggedUser.metadata == nil ){
            response(KWSChildren_UpdateParentEmail_NoValidUserLoggedIn);
            NSLog(kNoValidLoggedInUserMessage);
            return;
        }
        
        //User details with only parentEmail
        KWSUserDetails* userDetails = [[KWSUserDetails alloc] initWithId:nil
                                                                username:nil
                                                               firstName:nil
                                                                lastName:nil
                                                                 address:nil
                                                             dateOfBirth:nil
                                                                  gender:nil
                                                                language:nil
                                                                   email:nil
                                                             phoneNumber:nil
                                                       hasSetParentEmail:nil
                                                      applicationProfile:nil
                                                  applicationPermissions:nil
                                                                  points:nil
                                                               createdAt:nil
                                                             parentEmail:email];
        
        if(userDetails == nil){
            response(KWSChildren_UpdateParentEmail_NoValidUserDetails);
            NSLog(kNoValidUserDetailsMessage);
        }
        
        [userProvider updateUserDetailsWithUserId:(long)_loggedUser.metadata.userId
                                            token: _loggedUser.token
                                      userDetails:userDetails
                                         callback:^(BOOL success, NSError * error) {
                                             //
                                             //callback here
                                             if(success){
                                                 response(KWSChildren_UpdateParentEmail_Success);
                                             }else{
                                                 response(KWSChildren_UpdateParentEmail_NetworkError);
                                             }
                                             
                                         }];
    } else {
        NSLog(kProviderErrorMessage);
    }
    
    
    
    
}
    
- (void) requestPermission:(NSArray<NSNumber *> *)requestedPermissions
              withResponse:(KWSChildrenRequestPermissionBlock)response {

    UserProvider* userProvider = [[KWSSDK sharedInstance]
                                  getProviderWithEnvironment:_userKWSNetworkEnvironment
                                  type:NSStringFromClass([UserProvider class])];
    
    if ([userProvider isKindOfClass: [UserProvider class]]){
        
        if(_loggedUser == nil || _loggedUser.metadata == nil ){
            response(KWSChildren_RequestPermission_NetworkError);
            NSLog(kNoValidLoggedInUserMessage);
            return;
        }
        
        NSMutableArray<NSString*> *requestedPermissionsStringArray = [[NSMutableArray alloc] init];
        for (NSNumber *number in requestedPermissions) {
            NSInteger typeAsInt = [number integerValue];
            [requestedPermissionsStringArray addObject:[_requestPermission typeToString:typeAsInt]];
        }
        
        if(requestedPermissionsStringArray == nil || [requestedPermissionsStringArray count] == 0 ){
            response(KWSChildren_RequestPermission_NetworkError);
            NSLog(kNoValidPermissionsMessage);
            return;
        }
        
        [userProvider requestPermissionsWithUserId:(long)_loggedUser.metadata.userId
                                             token:_loggedUser.token
                                   permissionsList:requestedPermissionsStringArray
                                          callback:^(BOOL success, NSError * error) {
                                              //
                                              //callback here
                                              if(success){
                                                  response(KWSChildren_RequestPermission_Success);
                                              }else{
                                                  response(KWSChildren_RequestPermission_NetworkError);
                                              }
        }];
        
    }else{
        NSLog(kProviderErrorMessage);
    }
    
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
    
    @end
