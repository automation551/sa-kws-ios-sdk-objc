//
//  PushManager.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "PushManager.h"
#import "KWSLogger.h"

@interface PushManager ()
@property (nonatomic, weak) UIApplication *appRef;
@property (nonatomic, strong) id<UIApplicationDelegate> appDelegateRef;
@property (nonatomic, strong) PushCheckPermission *pushCheck;
@property (nonatomic, strong) PushRegisterPermission *pushRegister;
@property (nonatomic, assign) SEL settingsSelector;
@property (nonatomic, assign) SEL registeredSelector;
@end

@implementation PushManager

+ (PushManager*) sharedInstance {
    static PushManager *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype) init {
    if (self = [super init]) {
        _appRef = [UIApplication sharedApplication];
        _appDelegateRef = nil;
        _pushCheck = [[PushCheckPermission alloc] init];
        _pushRegister = [[PushRegisterPermission alloc] init];
        _settingsSelector = @selector(application:didRegisterUserNotificationSettings:);
        _registeredSelector = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
    }
    return self;
}

// <Public> function

- (void) registerForPushNotifications {
    [KWSLogger log:@"Start registering for Push Notifications | becoming App Delegate"];
    [self takeAppDelegateControl];
    UIUserNotificationType type = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
    [_appRef registerUserNotificationSettings:settings];
}

// <UIApplicationDelegate> functions

- (void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [self performSettingsSelector:application withSettings:notificationSettings];
    _pushCheck.delegate = self;
    [_pushCheck markSystemDialogAsSeen];
    [_pushCheck check];
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self performRegisteredSelector:application withData:deviceToken];
    [self resumeAppDelegateControl];
    NSString *token = [self getToken:deviceToken];
    [self delDidRegister];
    [KWSLogger log:[NSString stringWithFormat:@"Was able to register for Push Notifications with token %@", token]];
}

// <PushCheckPermision>

- (void) pushEnabledInSystem {
    [KWSLogger log:@"Push Notificaitons are enabled on system - start registration"];
    [_pushRegister registerPush];
}

- (void) pushDisabledInSystem {
    [KWSLogger err:@"Push Notifications are disabled on system - aborting registration"];
    [self resumeAppDelegateControl];
    [self delDidNotRegister];
}

// <Private> functions

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

- (void) takeAppDelegateControl {
    _appDelegateRef = [UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].delegate = self;
}

- (void) resumeAppDelegateControl {
    [UIApplication sharedApplication].delegate = _appDelegateRef;
}

// <Del> functions

- (void) delDidRegister {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didRegister)]){
        [_delegate didRegister];
    }
}

- (void) delDidNotRegister {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didNotRegister)] ) {
        [_delegate didNotRegister];
    }
}

@end
