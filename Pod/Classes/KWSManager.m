//
//  KWSManager.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSManager.h"

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
    _pushCheck.delegate = self;
    [_pushCheck check];
}

// <PushCheckPermisionProtocol>

- (void) pushEnabledInSystem {
    _kwsCheck.delegate = self;
    [_kwsCheck check];
}

- (void) pushDisabledInSystem {
    [self delPushDisabledInKWS];
}

// <KWSCheckPermissionProtocol>

- (void) pushEnabledInKWS {
    _pushRegister.delegate = self;
    [_pushRegister isRegistered];
}

- (void) pushDisabledInKWS {
    [_pushRegister unregisterPush];
    [self delPushDisabledInKWS];
}

- (void) checkError {
    [self delNetworkError];
}

// <PushRegisterPermissionProtocol>

- (void) isRegisteredInSystem {
    [self delIsAlreadyRegistered];
}

- (void) isNotRegisteredInSystem {
    _kwsRequest.delegate = self;
    [_kwsRequest request];
}

// <KWSRequestPermissionProtocol>

- (void) pushPermissionRequestedInKWS {
    [self delIsAllowedToRegister];
}

- (void) parentEmailIsMissingInKWS {
    [self delParentEmailIsMissingInKWS];
}

- (void) requestError {
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
