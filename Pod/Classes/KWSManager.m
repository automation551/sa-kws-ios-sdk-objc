//
//  KWSManager.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSManager.h"
#import "KWSLogger.h"

@interface KWSManager ()
@property (nonatomic, strong) PushCheckAllowed *pushCheckAllowed;
@property (nonatomic, strong) PushCheckRegistered *pushCheckRegistered;
@property (nonatomic, strong) PushRegister *pushRegister;
@property (nonatomic, strong) KWSCheckAllowed *kwsCheckAllowed;
@property (nonatomic, strong) KWSRequestPermission *kwsRequest;
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
        _kwsCheckAllowed = [[KWSCheckAllowed alloc] init];
        _pushRegister = [[PushRegister alloc] init];
        _pushCheckRegistered = [[PushCheckRegistered alloc] init];
        _kwsRequest = [[KWSRequestPermission alloc] init];
    }
    return self;
}

// MARL: Public function

- (void) checkIfNotificationsAreAllowed {
    [KWSLogger log:@"Checking to see if Push Notificactions are allowed"];
    _pushCheckAllowed.delegate = self;
    [_pushCheckAllowed check];
}

// MARK: PushCheckAllowedProtocol

- (void) pushAllowedInSystem {
    [KWSLogger log:@"Push Notifications enabled on user system"];
    _kwsCheckAllowed.delegate = self;
    [_kwsCheckAllowed check];
}

- (void) pushNotAllowedInSystem {
    [KWSLogger err:@"Push Notifications disabled on user system"];
    [self delPushNotAllowedInSystem];
}


// MARK: KWSCheckAllowedProtocol

- (void) pushAllowedInKWS {
    [KWSLogger log:@"Push Notifications enabled for user in KWS"];
    _pushCheckRegistered.delegate = self;
    [_pushCheckRegistered isRegistered];
}

- (void) pushNotAllowedInKWS {
    [KWSLogger err:@"Push Notifications disabled for user in KWS"];
    [_pushRegister unregisterPush];
    [self delPushNotAllowedInKWS];
}

- (void) checkError {
    [KWSLogger err:@"An unknown network error occured"];
    [self delNetworkError];
}

// MARK: PushCheckRegisteredProtocol

- (void) isRegisteredInSystem {
    [KWSLogger log:@"User has already registered for Push Notifications"];
    [self delIsAlreadyRegistered];
}

- (void) isNotRegisteredInSystem {
    [KWSLogger log:@"User is not yet registered for Push Notificaitons, starting request"];
    _kwsRequest.delegate = self;
    [_kwsRequest request];
}

// MARK: KWSRequestPermissionProtocol

- (void) pushPermissionRequestedInKWS {
    [KWSLogger log:@"Was able to request new Push Notification permissions in KWS"];
    [self delIsAllowedToRegister];
}

- (void) parentEmailIsMissingInKWS {
    [KWSLogger err:@"Was not able to request new Push Notificaiton permissions in KWS (parent email missing)"];
    [self delParentEmailIsMissingInKWS];
}

- (void) requestError {
    [KWSLogger err:@"An unknown network error occured"];
    [self delNetworkError];
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

- (void) delNetworkError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(networkError)]) {
        [_delegate networkError];
    }
}

- (void) delIsAllowedToRegister {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isAllowedToRegister)]) {
        [_delegate isAllowedToRegister];
    }
}

- (void) delIsAlreadyRegistered {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isAlreadyRegistered)]) {
        [_delegate isAlreadyRegistered];
    }
}

@end
