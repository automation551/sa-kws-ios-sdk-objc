//
//  PushManager.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushManager.h"
#import "SALogger.h"
#import "SASystemVersion.h"
#import "PushCheckAllowed.h"

@interface PushManager ()
@property (nonatomic, weak) UIApplication *appRef;
@property (nonatomic, strong) FirebaseGetToken *firebaseGetToken;
@property (nonatomic, strong) KWSSubscribeToken *kwsSubscribeToken;
@property (nonatomic, strong) KWSUnsubscribeToken *kwsUnsubscribeToken;
@property (nonatomic, strong) PushCheckAllowed *pushCheckAllowed;

@end

@implementation PushManager

// MARK: Init functions

+ (instancetype) sharedInstance {
    static PushManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id) init {
    if (self = [super init]) {
        _appRef = [UIApplication sharedApplication];
        _firebaseGetToken = [[FirebaseGetToken alloc] init];
        _firebaseGetToken.delegate = self;
        _kwsSubscribeToken = [[KWSSubscribeToken alloc] init];
        _kwsSubscribeToken.delegate = self;
        _kwsUnsubscribeToken = [[KWSUnsubscribeToken alloc] init];
        _kwsUnsubscribeToken.delegate = self;
        _pushCheckAllowed = [[PushCheckAllowed alloc] init];
    }
    return self;
}

// MARK: Public functions

- (void) registerForPushNotifications {
    [SALogger log:@"Start registering for Push Notifications"];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [_appRef registerUserNotificationSettings:settings];
        [_appRef registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType allNotificationTypes = (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge);
        [_appRef registerForRemoteNotificationTypes:allNotificationTypes];
    }
    
    // mark this
    [_pushCheckAllowed markSystemDialogAsSeen];
    
    // start setting up
    [_firebaseGetToken setup];
}

- (void) unregisterForPushNotifications {
    [SALogger log:@"Starting unregistering for Push Notificaitons"];
    NSString *token = [_firebaseGetToken getFirebaseToken];
    [_kwsUnsubscribeToken request:token];
}

// MARK: Firebase Protocol

- (void) didGetFirebaseToken: (NSString*) token {
    [_kwsSubscribeToken request:token];
}

- (void) didFailToGetFirebaseToken {
    [self delDidFailToGetFirebaseToken];
}

- (void) didFailBecauseFirebaseIsNotSetup {
    [self delDidFailBecauseFirebaseIsNotSetup];
}

// MARK: KWSSubscribeTokenProtocol

- (void) tokenWasSubscribed {
    NSString *token = [_firebaseGetToken getFirebaseToken];
    [self delDidRegister:token];
}

- (void) tokenSubscribeError {
    [self delNetworkErrorTryingToSubscribeToken];
}

// MARK: KWSUnsubscribeTokenProtocol

- (void) tokenWasUnsubscribed {
    [self delDidUnregister];
}

- (void) tokenUnsubscribeError {
    [self delNetworkErrorTryingToUnsubscribeToken];
}

// MARK: Delegate handler functions

- (void) delDidRegister:(NSString*)token {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didRegister:)]){
        [_delegate didRegister:token];
    }
}

- (void) delDidUnregister {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didUnregister)]) {
        [_delegate didUnregister];
    }
}

- (void) delDidFailBecauseFirebaseIsNotSetup {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailBecauseFirebaseIsNotSetup)]) {
        [_delegate didFailBecauseFirebaseIsNotSetup];
    }
}

- (void) delDidFailToGetFirebaseToken {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailToGetFirebaseToken)]) {
        [_delegate didFailToGetFirebaseToken];
    }
}

- (void) delNetworkErrorTryingToSubscribeToken {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(networkErrorTryingToSubscribeToken)]) {
        [_delegate networkErrorTryingToSubscribeToken];
    }
}

- (void) delNetworkErrorTryingToUnsubscribeToken {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(networkErrorTryingToUnsubscribeToken)]) {
        [_delegate networkErrorTryingToUnsubscribeToken];
    }
}
@end
