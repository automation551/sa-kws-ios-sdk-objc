//
//  KWSManager.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSManager.h"
#import "SALogger.h"

@interface KWSManager ()
@property (nonatomic, strong) PushCheckAllowed *pushCheckAllowed;
@property (nonatomic, strong) KWSCheckAllowed *kwsCheckAllowed;
@property (nonatomic, strong) KWSRequestPermission *kwsRequestPermission;
@end

@implementation KWSManager

+ (instancetype) sharedInstance {
    static KWSManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id) init {
    if (self = [super init]) {
        _pushCheckAllowed = [[PushCheckAllowed alloc] init];
        _pushCheckAllowed.delegate = self;
        _kwsRequestPermission = [[KWSRequestPermission alloc] init];
        _kwsRequestPermission.delegate = self;
        _kwsCheckAllowed = [[KWSCheckAllowed alloc] init];
        _kwsCheckAllowed.delegate = self;
    }
    return self;
}

// MARL: Public function

- (void) checkIfNotificationsAreAllowed {
    [SALogger log:@"Checking to see if Push Notificactions are allowed"];
    [_pushCheckAllowed check];
}

// MARK: PushCheckAllowedProtocol

- (void) pushAllowedInSystem {
    [SALogger log:@"Push Notifications enabled on user system"];
    [_kwsCheckAllowed execute];
}

- (void) pushNotAllowedInSystem {
    [SALogger err:@"Push Notifications disabled on user system"];
    [self delPushNotAllowedInSystem];
    // unsubscribe (optional, maybe?)
}

// MARK: KWSCheckAllowedProtocol

- (void) pushAllowedInKWS {
    [SALogger log:@"Push Notifications enabled for user in KWS"];
    [_kwsRequestPermission execute];
}

- (void) pushNotAllowedInKWS {
    [SALogger err:@"Push Notifications disabled for user in KWS"];
    [self delPushNotAllowedInKWS];
}

- (void) checkAllowedError {
    [SALogger err:@"Network error checking if KWS allows notifications"];
    [self delNetworkErrorCheckingInKWS];
}

// MARK: KWSRequestPermissionProtocol

- (void) pushPermissionRequestedInKWS {
    [SALogger log:@"Was able to request new Push Notification permissions in KWS"];
    [self delIsAllowedToRegister];
}

- (void) parentEmailIsMissingInKWS {
    [SALogger err:@"Was not able to request new Push Notificaiton permissions in KWS (parent email missing)"];
    [self delParentEmailIsMissingInKWS];
}

- (void) permissionError {
    [SALogger err:@"Network error requesting notification permission from KWS"];
    [self delNetworkErrorRequestingPermissionFromKWS];
}

// MARK: Delegate handler functions

- (void) delPushNotAllowedInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushNotAllowedInSystem)]) {
        [_delegate pushNotAllowedInSystem];
    }
}

- (void) delPushNotAllowedInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushNotAllowedInKWS)]) {
        [_delegate pushNotAllowedInKWS];
    }
}

- (void) delParentEmailIsMissingInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(parentEmailIsMissingInKWS)]) {
        [_delegate parentEmailIsMissingInKWS];
    }
}

- (void) delIsAllowedToRegister {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isAllowedToRegister)]) {
        [_delegate isAllowedToRegister];
    }
}

- (void) delNetworkErrorCheckingInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(networkErrorCheckingInKWS)]) {
        [_delegate networkErrorCheckingInKWS];
    }
}

- (void) delNetworkErrorRequestingPermissionFromKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(networkErrorRequestingPermissionFromKWS)]) {
        [_delegate networkErrorRequestingPermissionFromKWS];
    }
}

@end
