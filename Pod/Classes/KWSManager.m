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
@property (nonatomic, strong) PushCheckPermission *pushCheck;
@property (nonatomic, strong) KWSCheckPermission *kwsCheck;
@property (nonatomic, strong) PushRegisterPermission *pushRegister;
@property (nonatomic, strong) KWSRequestPermission *kwsRequest;
@end

@implementation KWSManager

+ (KWSManager*) sharedInstance {
    static KWSManager *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype) init {
    if (self = [super init]) {
        _pushCheck = [[PushCheckPermission alloc] init];
        _kwsCheck = [[KWSCheckPermission alloc] init];
        _pushRegister = [[PushRegisterPermission alloc] init];
        _kwsRequest = [[KWSRequestPermission alloc] init];
    }
    return self;
}

// Public function

- (void) checkIfNotificationsAreAllowed {
    [KWSLogger log:@"Checking to see if Push Notificactions are allowed"];
    _pushCheck.delegate = self;
    [_pushCheck check];
}

// <PushCheckPermisionProtocol>

- (void) pushEnabledInSystem {
    [KWSLogger log:@"Push Notifications enabled on user system"];
    _kwsCheck.delegate = self;
    [_kwsCheck check];
}

- (void) pushDisabledInSystem {
    [KWSLogger err:@"Push Notifications disabled on user system"];
    [self delPushDisabledInKWS];
}

// <KWSCheckPermissionProtocol>

- (void) pushEnabledInKWS {
    [KWSLogger log:@"Push Notifications enabled for user in KWS"];
    _pushRegister.delegate = self;
    [_pushRegister isRegistered];
}

- (void) pushDisabledInKWS {
    [KWSLogger err:@"Push Notifications disabled for user in KWS"];
    [_pushRegister unregisterPush];
    [self delPushDisabledInKWS];
}

- (void) checkError {
    [KWSLogger err:@"An unknown network error occured"];
    [self delNetworkError];
}

// <PushRegisterPermissionProtocol>

- (void) isRegisteredInSystem {
    [KWSLogger log:@"User has already registered for Push Notifications"];
    [self delIsAlreadyRegistered];
}

- (void) isNotRegisteredInSystem {
    [KWSLogger log:@"User is not yet registered for Push Notificaitons, starting request"];
    _kwsRequest.delegate = self;
    [_kwsRequest request];
}

// <KWSRequestPermissionProtocol>

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

// <Proto> quick functions

- (void) delPushDisabledInSystem {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushDisabledInSystem)]) {
        [_delegate pushDisabledInSystem];
    }
}

- (void) delPushDisabledInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushDisabledInKWS)]) {
        [_delegate pushDisabledInKWS];
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
