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
#import "Firebase.h"
#import "KWSSubscribeToken.h"

@interface PushManager ()
@property (nonatomic, weak) UIApplication *appRef;
@property (nonatomic, strong) id<UIApplicationDelegate> appDelegateRef;
@property (nonatomic, strong) PushCheckAllowed *pushCheckAllowed;
@property (nonatomic, strong) PushCheckRegistered *pushCheckRegistered;
@property (nonatomic, strong) PushRegister *pushRegister;
@property (nonatomic, assign) SEL settingsSelector;
@property (nonatomic, assign) SEL registeredSelector;
@property (nonatomic, assign) SEL failureSelector;
@property (nonatomic, strong) NSString *tmpSystemToken;
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
        _appDelegateRef = nil;
        _pushCheckAllowed = [[PushCheckAllowed alloc] init];
        _pushCheckRegistered = [[PushCheckRegistered alloc] init];
        _pushRegister = [[PushRegister alloc] init];
        _settingsSelector = @selector(application:didRegisterUserNotificationSettings:);
        _registeredSelector = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
        _failureSelector = @selector(application:didFailToRegisterForRemoteNotificationsWithError:);
    }
    return self;
}

// MARK: Public functions

- (void) registerForPushNotifications {
    [SALogger log:@"Start registering for Push Notifications | becoming App Delegate"];
    [self takeAppDelegateControl];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationType type = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [_appRef registerUserNotificationSettings:settings];
    }
    else {
        [_pushRegister registerPush];
    }
}

- (void) unregisterForPushNotifications {
    [SALogger log:@"Starting unregistering for Push Notificaitons"];
    [_pushRegister unregisterPush];
    [self delDidUnregisterWithSystem];
}

// MARK: UIApplicationDelegate

- (void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [self performSettingsSelector:application withSettings:notificationSettings];
    _pushCheckAllowed.delegate = self;
    [_pushCheckAllowed markSystemDialogAsSeen];
    [_pushCheckAllowed check];
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self performRegisteredSelector:application withData:deviceToken];
    [self resumeAppDelegateControl];
    [self delDidRegisterWithSystem:deviceToken];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [self performFailureSelector:application withError:error];
    [self resumeAppDelegateControl];
    [self delDidNotRegister];
    [SALogger err:@"Failed to register for Push Notification"];
}

// MARK: PushCheckAllowed

- (void) pushAllowedInSystem {
    [SALogger log:@"Push Notificaitons are enabled on system - start registration"];
    [_pushRegister registerPush];
}

- (void) pushNotAllowedInSystem {
    [SALogger err:@"Push Notifications are disabled on system - aborting registration"];
    [self resumeAppDelegateControl];
    [self delDidNotRegister];
}

// MARK: Private functions

- (NSString*) getToken:(NSData *)deviceToken {
    const char* data = [deviceToken bytes];
    NSMutableString* token = [NSMutableString string];
    for (int i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }
    return token;
}

- (void) performSettingsSelector:(UIApplication*)app withSettings:(UIUserNotificationSettings*)settings {
    if (_appDelegateRef != NULL && [_appDelegateRef respondsToSelector:_settingsSelector]) {
        [_appDelegateRef performSelector:_settingsSelector withObject:app withObject:settings];
    }
}

- (void) performRegisteredSelector:(UIApplication*)app withData:(NSData*)token {
    if (_appDelegateRef != NULL && [_appDelegateRef respondsToSelector:_registeredSelector]){
        [_appDelegateRef performSelector:_registeredSelector withObject:app withObject:token];
    }
}

- (void) performFailureSelector:(UIApplication*)app withError:(NSError*)error {
    if (_appDelegateRef != NULL && [_appDelegateRef respondsToSelector:_failureSelector]) {
        [_appDelegateRef performSelector:_failureSelector withObject:app withObject:error];
    }
}

- (void) takeAppDelegateControl {
    _appDelegateRef = [UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].delegate = self;
}

- (void) resumeAppDelegateControl {
    [UIApplication sharedApplication].delegate = _appDelegateRef;
}

// MARK: Delegate handler functions

- (void) delDidRegisterWithSystem:(NSString*)token {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didRegisterWithSystem:)]) {
        [_delegate didRegisterWithSystem:token];
    }
}

- (void) delDidNotRegister {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didNotRegister)] ) {
        [_delegate didNotRegister];
    }
}

- (void) delDidUnregisterWithSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didUnregisterWithSystem)]) {
        [_delegate didUnregisterWithSystem];
    }
}

@end
