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
#import "KWSLogger.h"
#import "KWSSubscribeToken.h"
#import "KWSUnsubscribeToken.h"
#import "FirebaseGetToken.h"
#import "KWSPopup.h"

@interface KWS () <KWSManagerProtocol, PushManagerProtocol, KWSParentEmailProtocol, KWSSubscribeTokenProtocol, KWSUnsubscribeTokenProtocol, FirebaseGetTokenProtocol>
// the parent email object
@property (nonatomic, strong) KWSParentEmail *parentEmail;

// KWS setup properties
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;
@property (nonatomic, assign) BOOL showPermissionPopup;
@property (nonatomic, weak) id <KWSProtocol> delegate;

// email popup
@property (nonatomic, strong) KWSPopup *permissionPopup;
@property (nonatomic, strong) KWSPopup *emailPopup;

// internal vars
@property (nonatomic, strong) NSString *systemToken;
@property (nonatomic, strong) NSString *firebaseToken;
@property (nonatomic, strong) FirebaseGetToken *firebaseGetToken;
@property (nonatomic, strong) KWSSubscribeToken *subscribeToken;
@property (nonatomic, strong) KWSUnsubscribeToken *unsubscribeToken;
@end

@implementation KWS

+ (KWS*) sdk {
    static KWS *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype) init {
    if (self = [super init]) {
        [KWSManager sharedInstance].delegate = self;
        [PushManager sharedInstance].delegate = self;
        _subscribeToken = [[KWSSubscribeToken alloc] init];
        _subscribeToken.delegate = self;
        _firebaseGetToken = [[FirebaseGetToken alloc] init];
        _firebaseGetToken.delegate = self;
        _unsubscribeToken = [[KWSUnsubscribeToken alloc] init];
        _unsubscribeToken.delegate = self;
    }
    return self;
}

// MARK: Setup function

- (void) setupWithOAuthToken:(NSString*)oauthToken
                   kwsApiUrl:(NSString*)kwsApiUrl
          andPermissionPopup:(BOOL)showPermissionPopup
                    delegate:(id<KWSProtocol>)delegate {
    _showPermissionPopup = showPermissionPopup;
    _oauthToken = oauthToken;
    _kwsApiUrl = kwsApiUrl;
    _delegate = delegate;
    _metadata = [self getMetadata:oauthToken];
    [KWSLogger log:[self.metadata jsonPreetyStringRepresentation]];
}

// MARK: Public functions

- (void) checkIfNotificationsAreAllowed {
    if (_showPermissionPopup) {
        _permissionPopup = [[KWSPopup alloc] init];
        [_permissionPopup showWithTitle:@"Hey!"
                             andMessage:@"Do you want to allow Push Notifications?"
                             andOKTitle:@"Yes"
                            andNOKTitle:@"No"
                           andTextField:NO
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

- (void) showParentEmailPopup {
    _emailPopup = [[KWSPopup alloc] init];
    [_emailPopup showWithTitle:@"Hey!"
                    andMessage:@"To enable Push Notifications in KWS you'll need to provide a parent's email."
                    andOKTitle:@"Submut"
                   andNOKTitle:@"Cancel"
                  andTextField:YES
                    andOKBlock:^(NSString *popupMessage) {
                        [self submitParentEmail:popupMessage];
                    } andNOKBlock:^{
                        // nothing
                    }];
}

- (void) submitParentEmail:(NSString*)email {
    _parentEmail = [[KWSParentEmail alloc] init];
    _parentEmail.delegate = self;
    [_parentEmail submit:email];
}

- (void) registerForRemoteNotifications {
    [[PushManager sharedInstance] registerForPushNotifications];
}

- (void) unregisterForRemoteNotifications {
    [[PushManager sharedInstance] unregisterForPushNotifications];
}

// MARK: KWSManagerProtocol delegate

- (void) pushNotAllowedInSystem {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NoSystemPermission];
}

- (void) pushNotAllowedInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NoKWSPermission];
}

- (void) parentEmailIsMissingInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:ParentEmailNotFound];
}

- (void) networkError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError];
}

- (void) isAllowedToRegister {
    [self delKWSSDKDoesAllowUserToRegisterForRemoteNotifications];
}

- (void) isAlreadyRegistered {
    // case when all is OK
    if ([_firebaseGetToken getFirebaseToken]) {
        [self delKWSSDKDidRegisterUserForRemoteNotifications];
    }
    // case when somehow the Firebase token hasn't been properly saved
    else {
        [self didRegisterWithSystem:nil];
    }
}

// MARK: KWSParentEmailProtocol delegate

- (void) emailSubmittedInKWS {
    [self delKWSSDKDoesAllowUserToRegisterForRemoteNotifications];
}

- (void) emailError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:ParentEmailInvalid];
}

// MARK: PushManagerProtocol delegate

- (void) didRegisterWithSystem:(NSString *)token {
    _systemToken = token;
    [_firebaseGetToken setup];
}

- (void) didNotRegister {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NoSystemPermission];
}

- (void) didUnregisterWithSystem {
    NSString *token = [_firebaseGetToken getFirebaseToken];
    [_unsubscribeToken request:token];
}

// MARK: FirebaseGetTokenProtocol delegate

- (void) didGetFirebaseToken: (NSString*) token {
    _firebaseToken = token;
    [_subscribeToken request:token];
}

- (void) didFailToGetFirebaseToken {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FirebaseCouldNotGetToken];
}

- (void) didFailBecauseFirebaseIsNotSetup {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FirebaseNotSetup];
}

// MARK: KWSSubscribeTokenProtocol delegate

- (void) tokenWasSubscribed {
    [KWSLogger log:[NSString stringWithFormat:@"Did register with\n - System Token: %@\n - Firebase Token: %@", _systemToken, _firebaseToken]];
    [self delKWSSDKDidRegisterUserForRemoteNotifications];
}

- (void) tokenSubscribeError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError];
}

// MARK: KWSUnsubscribeTokenProtocol delegate

- (void) tokenWasUnsubscribed {
    [self delKWSSDKDidUnregisterUserForRemoteNotifications];
}

- (void) tokenUnsubscribeError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:CouldNotUnsubscribeInKWS];
}

// MARK: getters

- (NSString*) getOAuthToken {
    return _oauthToken;
}

- (NSString*) getKWSApiUrl {
    return _kwsApiUrl;
}

- (KWSMetadata*) getMetadata {
    return _metadata;
}

// MARL: Private function

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

- (void) delKWSSDKDoesAllowUserToRegisterForRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(kwsSDKDoesAllowUserToRegisterForRemoteNotifications)]) {
        [_delegate kwsSDKDoesAllowUserToRegisterForRemoteNotifications];
    }
}

- (void) delKWSSDKDidRegisterUserForRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(kwsSDKDidRegisterUserForRemoteNotifications)]) {
        [_delegate kwsSDKDidRegisterUserForRemoteNotifications];
    }
}

- (void) delKWSSDKDidUnregisterUserForRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(kwsSDKDidUnregisterUserForRemoteNotifications)]) {
        [_delegate kwsSDKDidUnregisterUserForRemoteNotifications];
    }
}

- (void) delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:)]) {
        [_delegate kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:errorType];
    }
}

@end
