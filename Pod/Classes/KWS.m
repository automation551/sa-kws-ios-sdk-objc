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
#import "SAPopup.h"

@interface KWS () <KWSManagerProtocol, PushManagerProtocol, KWSParentEmailProtocol>
// the parent email object
@property (nonatomic, strong) KWSParentEmail *parentEmail;

// KWS setup properties
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;
@property (nonatomic, assign) BOOL showPermissionPopup;
@property (nonatomic, weak) id <KWSProtocol> delegate;

// email popup
@property (nonatomic, strong) SAPopup *permissionPopup;
@property (nonatomic, strong) SAPopup *emailPopup;

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
        _parentEmail = [[KWSParentEmail alloc] init];
        _parentEmail.delegate = self;
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
    [SALogger log:[self.metadata jsonPreetyStringRepresentation]];
}

// MARK: Public functions

- (void) registerForRemoteNotifications {
    if (_showPermissionPopup) {
        _permissionPopup = [[SAPopup alloc] init];
        [_permissionPopup showWithTitle:@"Hey!"
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

- (void) unregisterForRemoteNotifications {
    [[PushManager sharedInstance] unregisterForPushNotifications];
}

- (void) showParentEmailPopup {
    _emailPopup = [[SAPopup alloc] init];
    [_emailPopup showWithTitle:@"Hey!"
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
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NoSystemPermission];
}

- (void) pushNotAllowedInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NoKWSPermission];
}

- (void) parentEmailIsMissingInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:ParentEmailNotFound];
}

- (void) networkErrorCheckingInKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError_CheckKWSAllowsNotifications];
}

- (void) networkErrorRequestingPermissionFromKWS {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError_RequestPermissionFromKWS];
}

- (void) isAllowedToRegister {
    [[PushManager sharedInstance] registerForPushNotifications];
}

// MARK: KWSParentEmailProtocol delegate

- (void) emailSubmittedInKWS {
    [[PushManager sharedInstance] registerForPushNotifications];
}

- (void) emailError {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError_SubmitEmail];
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
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError_SubscribeTokenToKWS];
}

- (void) networkErrorTryingToUnsubscribeToken {
    [self delKWSSDKDidFailToRegisterUserForRemoteNotificationsWithError:NetworkError_UnsubscribeTokenToKWS];
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
