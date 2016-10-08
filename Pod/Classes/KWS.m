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

@interface KWS ()

// the parent email object
@property (nonatomic, strong) NotificationProcess *notificationProcess;
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

// KWS setup properties
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;

// aux variables

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
        _notificationProcess = [[NotificationProcess alloc] init];
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

- (void) startSessionWithToken:(NSString*) token
                     andAPIUrl:(NSString*) url {
    
    _oauthToken = token;
    _kwsApiUrl = url;
    if (_oauthToken != NULL) {
        _metadata = [self processMetadata:_oauthToken];
    }
    if (_metadata != NULL) {
        [SALogger log:[self.metadata jsonPreetyStringRepresentation]];
    }
}

- (void) stopSession {
    _oauthToken = NULL;
    _kwsApiUrl = NULL;
    _metadata = NULL;
}

// MARK: public simple functions

- (void) register:(registered)registered {
    [_notificationProcess register:registered];
}

- (void) unregister:(unregistered)unregistered {
    [_notificationProcess unregister:unregistered];
}

- (void) isRegistered:(isRegistered)isRegistered {
    [_notificationProcess isRegistered:isRegistered];
}

- (void) createUser:(NSString *)username withPassword:(NSString *)password andDateOfBirth:(NSString *)dateOfBirth andCountry:(NSString *)country :(created)created {
    [_createUser execute:username andPassword:password andDateOfBirth:dateOfBirth andCountry:country :created];
}

- (void) submitParentEmail:(NSString *)email :(submitted)submitted {
    [_parentEmail execute:email :submitted];
}

- (void) getUser:(gotUser)gotUser {
    [_getUser execute:gotUser];
}

- (void) getLeaderboard:(gotLeaderboard)gotLeaderboard {
    [_getLeaderboard execute:gotLeaderboard];
}

- (void) requestPermission:(NSArray<NSNumber *> *)requestedPermissions :(requested)requested {
    [_requestPermission execute:requestedPermissions :requested];
}

- (void) triggerEvent:(NSString *)event withPoints:(NSInteger)points andDescription:(NSString *)description :(triggered)triggered {
    [_triggerEvent execute:event points:points description:description :triggered];
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
                                        [self submitParentEmail:popupMessage :submitted];
                                    }
                                }];
}

- (void) getScore:(gotScore)gotscore {
    [_getScore execute:gotscore];
}

- (void) inviteUser:(NSString*)email :(invited)invited {
    [_inviteUser execute:email :invited];
}

- (void) hasTriggeredEvent:(NSInteger) eventId : (hasTriggered)triggered {
    [_hasTriggeredEvent execute:eventId :triggered];
}

- (void) getAppData:(gotAppData)gotappdata {
    [_getAppData execute:gotappdata];
}

- (void) setAppData:(NSString*)name withValue:(NSInteger)value :(setAppData)setappdata {
    [_setAppData execute:name withValue:value :setappdata];
}

- (void) updateUser:(KWSUser*)updatedUser :(updated)updated {
    [_updateUser execute:updatedUser :updated];
}

// MARK: getters

- (NSString*) getVersion {
    return @"ios-2.0.12";
}

- (NSString*) getOAuthToken {
    return _oauthToken;
}

- (NSString*) getKWSApiUrl {
    return _kwsApiUrl;
}

- (KWSMetadata*) getMetadata {
    return _metadata;
}

// MARK: Private function

- (KWSMetadata*) processMetadata:(NSString*)oauthToken {
    NSArray *subtokens = [oauthToken componentsSeparatedByString:@"."];
    NSString *token = nil;
    if (subtokens.count >= 2) token = subtokens[1];
    if (token == nil) return nil;
    
    NSString *token0 = token;
    NSString *token1 = [token0 stringByAppendingString:@"="];
    NSString *token2 = [token1 stringByAppendingString:@"="];
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:token0 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (decodedData == nil) {
        decodedData = [[NSData alloc] initWithBase64EncodedString:token1 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if (decodedData == nil) {
            decodedData = [[NSData alloc] initWithBase64EncodedString:token2 options:NSDataBase64DecodingIgnoreUnknownCharacters];
            if (decodedData == nil) return nil;
        }
    }
    
    NSString *decodedJson = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return [[KWSMetadata alloc] initWithJsonString:decodedJson];
}

@end
