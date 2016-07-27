//
//  KWS.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWS.h"
#import "KWSMetadata.h"
#import "Firebase.h"
#import "SALogger.h"
#import "KWSSubscribeToken.h"
#import "KWSUnsubscribeToken.h"
#import "FirebaseGetToken.h"
#import "KWSGetUser.h"
#import "SAPopup.h"

@interface KWS () <KWSManagerProtocol, PushManagerProtocol, KWSParentEmailProtocol, CheckManagerProtocol>

// the parent email object
@property (nonatomic, strong) KWSParentEmail *parentEmail;

// KWS setup properties
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;
@property (nonatomic, assign) BOOL showPermissionPopup;

// email popup
@property (nonatomic, strong) SAPopup *permissionPopup;
@property (nonatomic, strong) SAPopup *emailPopup;

// delegates
@property (nonatomic, weak) id <KWSRegisterProtocol> registerDelegate;
@property (nonatomic, weak) id <KWSUnregisterProtocol> unregisterDelegate;
@property (nonatomic, weak) id <KWSCheckProtocol> checkDelegate;

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
        [KWSManager sharedInstance].delegate = self;
        [PushManager sharedInstance].delegate = self;
        [CheckManager sharedInstance].delegate = self;
        _parentEmail = [[KWSParentEmail alloc] init];
        _parentEmail.delegate = self;
    }
    return self;
}

// MARK: Setup function

- (void) setupWithOAuthToken:(NSString*)oauthToken
                   kwsApiUrl:(NSString*)kwsApiUrl
          andPermissionPopup:(BOOL)showPermissionPopup {
    
    _showPermissionPopup = showPermissionPopup;
    _oauthToken = oauthToken;
    _kwsApiUrl = kwsApiUrl;
    _metadata = [self getMetadata:oauthToken];
    [SALogger log:[self.metadata jsonPreetyStringRepresentation]];
}

// MARK: Public functions

- (void) registerForRemoteNotifications:(id<KWSRegisterProtocol>)delegate {
    
    // assign delegate
    _registerDelegate = delegate;
    
    // perform action
    if (_showPermissionPopup) {
        [[SAPopup sharedManager] showWithTitle:@"Hey!"
                             andMessage:@"Do you want to allow Push Notifications?"
                             andOKTitle:@"Yes"
                            andNOKTitle:@"No"
                           andTextField:NO
                        andKeyboardTyle:UIKeyboardTypeDefault
                             andOKBlock:^(NSString *popupMessage) {
                                 [[KWSManager sharedInstance] checkIfNotificationsAreAllowed];
                             }
                            andNOKBlock:^ {
                                // do nothing
                            }];
    }
    else {
        [[KWSManager sharedInstance] checkIfNotificationsAreAllowed];
    }
}

- (void) unregisterForRemoteNotifications:(id<KWSUnregisterProtocol>)delegate {
    // set delegate
    _unregisterDelegate = delegate;
    
    // perform action
    [[PushManager sharedInstance] unregisterForPushNotifications];
}

- (void) userIsRegistered:(id<KWSCheckProtocol>)delegate {
    // set delegate
    _checkDelegate = delegate;
    
    // perform action
    [[CheckManager sharedInstance] areNotificationsEnabled];
}

- (void) getUserProfile {
    KWSGetUser *kwsGetUser = [[KWSGetUser alloc] init];
    [kwsGetUser getUser];
}

- (void) showParentEmailPopup {
    [[SAPopup sharedManager] showWithTitle:@"Hey!"
                    andMessage:@"To enable Push Notifications in KWS you'll need to provide a parent's email."
                    andOKTitle:@"Submit"
                   andNOKTitle:@"Cancel"
                  andTextField:YES
               andKeyboardTyle:UIKeyboardTypeEmailAddress
                    andOKBlock:^(NSString *popupMessage) {
                        [self submitParentEmail:popupMessage];
                    } andNOKBlock:^{
                        // nothing
                    }];
}

- (void) submitParentEmail:(NSString*)email {
    [_parentEmail submit:email];
}

// MARK: KWSManagerProtocol delegate

- (void) pushNotAllowedInSystem {
    _unregisterDelegate = nil;
    [[PushManager sharedInstance] unregisterForPushNotifications];
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:UserHasDisabledRemoteNotifications];
}

- (void) pushNotAllowedInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:ParentHasDisabledRemoteNotifications];
}

- (void) parentEmailIsMissingInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:UserHasNoParentEmail];
}

- (void) networkErrorCheckingInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FailedToCheckIfUserHasNotificationsEnabledInKWS];
}

- (void) networkErrorRequestingPermissionFromKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FailedToRequestNotificationsPermissionInKWS];
}

- (void) isAllowedToRegister {
    [[PushManager sharedInstance] registerForPushNotifications];
}

// MARK: KWSParentEmailProtocol delegate

- (void) emailSubmittedInKWS {
    [[PushManager sharedInstance] registerForPushNotifications];
}

- (void) emailError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FailedToSubmitParentEmail];
}

- (void) invalidEmail {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:ParentEmailInvalid];
}

// MARK: PushManagerProtocol delegate

- (void) didRegister:(NSString*)token {
    [self delKWSSDKDidRegisterUserForRemoteNotifications];
}

- (void) didUnregister {
    [self delKWSSDKDidUnregisterUserForRemoteNotifications];
}

- (void) didFailBecauseFirebaseIsNotSetup {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FirebaseNotSetup];
}

- (void) didFailToGetFirebaseToken {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FirebaseCouldNotGetToken];
}

- (void) networkErrorTryingToSubscribeToken {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FailedToSubscribeTokenToKWS];
}

- (void) networkErrorTryingToUnsubscribeToken {
    [self delKWSSDKDidFailToUnregisterUserForRemoteNotifications];
}

// MARK: CheckManagerProtocol

- (void) pushAllowedOverall {
    [self delKWSSDKUserIsRegistered];
}

- (void) pushDisabledOverall {
    [self delKWSSDKUserIsNotRegistered];
}

- (void) networkErrorTryingToCheckUserStatus {
    [self delKWSSDKDidFailToCheckIfUserIsRegistered];
}

// MARK: getters

- (NSString*) getVersion {
    return @"ios-1.2.9";
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

- (KWSMetadata*) getMetadata:(NSString*)oauthToken {
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

// MARK: Delegate handler functions

- (void) delKWSSDKDidRegisterUserForRemoteNotifications {
    if (_registerDelegate != NULL && [_registerDelegate respondsToSelector:@selector(kwsSDKDidRegisterUserForRemoteNotifications)]) {
        [_registerDelegate kwsSDKDidRegisterUserForRemoteNotifications];
    }
}

- (void) delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType {
    if (_registerDelegate != NULL && [_registerDelegate respondsToSelector:@selector(kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:)]) {
        [_registerDelegate kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:errorType];
    }
}

- (void) delKWSSDKDidUnregisterUserForRemoteNotifications {
    if (_unregisterDelegate != NULL && [_unregisterDelegate respondsToSelector:@selector(kwsSDKDidUnregisterUserForRemoteNotifications)]) {
        [_unregisterDelegate kwsSDKDidUnregisterUserForRemoteNotifications];
    }
}

- (void) delKWSSDKDidFailToUnregisterUserForRemoteNotifications {
    if (_unregisterDelegate != NULL && [_unregisterDelegate respondsToSelector:@selector(kwsSDKDidFailToUnregisterUserForRemoteNotifications)]) {
        [_unregisterDelegate kwsSDKDidFailToUnregisterUserForRemoteNotifications];
    }
}

- (void) delKWSSDKUserIsRegistered {
    if (_checkDelegate != NULL && [_checkDelegate respondsToSelector:@selector(kwsSDKUserIsRegistered)]) {
        [_checkDelegate kwsSDKUserIsRegistered];
    }
}

- (void) delKWSSDKUserIsNotRegistered {
    if (_checkDelegate != NULL && [_checkDelegate respondsToSelector:@selector(kwsSDKUserIsNotRegistered)]) {
        [_checkDelegate kwsSDKUserIsNotRegistered];
    }
}

- (void) delKWSSDKDidFailToCheckIfUserIsRegistered {
    if (_checkDelegate != NULL && [_checkDelegate respondsToSelector:@selector(kwsSDKDidFailToCheckIfUserIsRegistered)]) {
        [_checkDelegate kwsSDKDidFailToCheckIfUserIsRegistered];
    }
}

@end
