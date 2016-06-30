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
#import "FirebaseGetToken.h"

@interface KWS () <KWSManagerProtocol, PushManagerProtocol, KWSParentEmailProtocol, KWSSubscribeTokenProtocol, FirebaseGetTokenProtocol>
// the parent email object
@property (nonatomic, strong) KWSParentEmail *parentEmail;

// KWS setup properties
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;
@property (nonatomic, strong) FirebaseGetToken *firebaseGetToken;
@property (nonatomic, strong) KWSSubscribeToken *subscribeToken;
@property (nonatomic, weak) id <KWSProtocol> delegate;

@property (nonatomic, strong) NSString *systemToken;
@property (nonatomic, strong) NSString *firebaseToken;

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
        
    }
    return self;
}

// <Setup> function

- (void) setupWithOAuthToken:(NSString*)oauthToken kwsApiUrl:(NSString*)kwsApiUrl delegate:(id<KWSProtocol>)delegate {
    self.oauthToken = oauthToken;
    self.kwsApiUrl = kwsApiUrl;
    self.delegate = delegate;
    self.metadata = [self getMetadata:oauthToken];
    [KWSLogger log:[self.metadata jsonPreetyStringRepresentation]];
}

// <Public> functions

- (void) checkIfNotificationsAreAllowed {
    [KWSManager sharedInstance].delegate = self;
    [[KWSManager sharedInstance] checkIfNotificationsAreAllowed];
}

- (void) submitParentEmail:(NSString*)email {
    _parentEmail = [[KWSParentEmail alloc] init];
    _parentEmail.delegate = self;
    [_parentEmail submit:email];
}

- (void) registerForRemoteNotifications {
    [PushManager sharedInstance].delegate = self;
    [[PushManager sharedInstance] registerForPushNotifications];
}

// <KWSManagerProtocol> delegate

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
    [self delKWSSDKDidRegisterUserForRemoteNotifications];
}

// <KWSParentEmailProtocol> delegate

- (void) emailSubmittedInKWS {
    [self delKWSSDKDoesAllowUserToRegisterForRemoteNotifications];
}

- (void) emailError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:ParentEmailInvalid];
}

// <PushManagerProtocol> delegate

- (void) didRegisterWithSystem:(NSString *)token {
    _firebaseGetToken = [[FirebaseGetToken alloc] init];
    _firebaseGetToken.delegate = self;
    _systemToken = token;
    [_firebaseGetToken setup];
}

- (void) didNotRegister {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError];
}

// <FirebaseGetTokenProtocol> delegate

- (void) didGetFirebaseToken: (NSString*) token {
    _subscribeToken = [[KWSSubscribeToken alloc] init];
    _subscribeToken.delegate = self;
    _firebaseToken = token;
    [_subscribeToken request:token];
}

- (void) didFailToGetFirebaseToken {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FirebaseCouldNotGetToken];
}

- (void) didFailBecauseFirebaseIsNotSetup {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:FirebaseNotSetup];
}

// <KWSSubscribeTokenProtocol> delegate

- (void) tokenWasSubscribed {
    [KWSLogger log:[NSString stringWithFormat:@"Did register with\n - System Token: %@\n - Firebase Token: %@", _systemToken, _firebaseToken]];
    [self delKWSSDKDidRegisterUserForRemoteNotifications];
}

- (void) tokenError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError];
}

// getters

- (NSString*) getOAuthToken {
    return _oauthToken;
}

- (NSString*) getKWSApiUrl {
    return _kwsApiUrl;
}

- (KWSMetadata*) getMetadata {
    return _metadata;
}

// <Private> function

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

// <Del> functions

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

- (void) delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:)]) {
        [_delegate kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:errorType];
    }
}

@end
