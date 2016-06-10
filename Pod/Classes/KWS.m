//
//  KWS.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWS.h"
#import "KWSMetadata.h"

@interface KWS ()
// the parent email object
@property (nonatomic, strong) KWSParentEmail *parentEmail;

// KWS setup properties
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;
@property (nonatomic, weak) id <KWSProtocol> delegate;

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
    NSLog(@"Json Model: %@", [self.metadata jsonPreetyStringRepresentation]);
    
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

- (void) pushDisabledInSystem {
    [self delDidFailBecauseRemoteNotificationsAreDisabled];
}

- (void) pushDisabledInKWS {
    [self delDidFailBecauseKWSDoesNotAllowRemoteNotifications];
}

- (void) parentEmailIsMissingInKWS {
    [self delDidFailBecauseKWSCouldNotFindParentEmail];
}

- (void) networkError {
    [self delDidFailBecauseOfError];
}

- (void) isAllowedToRegister {
    [self delIsAllowedToRegisterForRemoteNotifications];
}

- (void) isAlreadyRegistered {
    [self delIsAlreadyRegisteredForRemoteNotifications];
}

// <KWSParentEmailProtocol> delegate

- (void) emailSubmittedInKWS {
    [self delIsAllowedToRegisterForRemoteNotifications];
}

- (void) emailError {
    [self delDidFailBecauseOfError];
}

// <PushManagerProtocol> delegate

- (void) didRegister {
    [self delDidRegisterForRemoteNotifications];
}

- (void) didNotRegister {
    [self delDidFailBecauseOfError];
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

- (void) delIsAllowedToRegisterForRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isAllowedToRegisterForRemoteNotifications)]) {
        [_delegate isAllowedToRegisterForRemoteNotifications];
    }
}

- (void) delIsAlreadyRegisteredForRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isAlreadyRegisteredForRemoteNotifications)]) {
        [_delegate isAlreadyRegisteredForRemoteNotifications];
    }
}

- (void) delDidRegisterForRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didRegisterForRemoteNotifications)]) {
        [_delegate didRegisterForRemoteNotifications];
    }
}

- (void) delDidFailBecauseKWSDoesNotAllowRemoteNotifications {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailBecauseKWSDoesNotAllowRemoteNotificaitons)]) {
        [_delegate didFailBecauseKWSDoesNotAllowRemoteNotifications];
    }
}

- (void) delDidFailBecauseKWSCouldNotFindParentEmail {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailBecauseKWSCouldNotFindParentEmail)]) {
        [_delegate didFailBecauseKWSCouldNotFindParentEmail];
    }
}

- (void) delDidFailBecauseRemoteNotificationsAreDisabled {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailBecauseRemoteNotificationsAreDisabled)]) {
        [_delegate didFailBecauseRemoteNotificationsAreDisabled];
    }
}

- (void) delDidFailBecauseOfError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailBecauseOfError)]) {
        [_delegate didFailBecauseOfError];
    }
}

@end
