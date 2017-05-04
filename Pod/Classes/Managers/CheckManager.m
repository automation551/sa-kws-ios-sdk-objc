//
//  CheckManager.m
//  Pods
//
//  Created by Gabriel Coman on 12/07/2016.
//
//

#import "CheckManager.h"

// import headers
#import "PushCheckAllowed.h"
#import "KWSCheckAllowed.h"
#import "KWSCheckRegistered.h"

@interface CheckManager () <KWSCheckAllowedProtocol, PushCheckAllowedProtocol, KWSCheckRegisteredProtocol>
@property (nonatomic, strong) PushCheckAllowed *pushCheckAllowed;
@property (nonatomic, strong) KWSCheckAllowed *kwsCheckAllowed;
@property (nonatomic, strong) KWSCheckRegistered *kwsCheckRegistered;
@end

@implementation CheckManager

+ (instancetype) sharedInstance {
    static CheckManager *sharedMyManager = nil;
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
        _kwsCheckAllowed = [[KWSCheckAllowed alloc] init];
        _kwsCheckAllowed.delegate = self;
        _kwsCheckRegistered = [[KWSCheckRegistered alloc] init];
        _kwsCheckRegistered.delegate = self;
    }
    return self;
}

// MARK: Main functions

- (void) areNotificationsEnabled {
    [_pushCheckAllowed check];
}

// MARK: PushCheckAllowedProtocol

- (void) pushAllowedInSystem {
    NSLog(@"Checking | User has allowed Remote Notifications in system");
    [_kwsCheckAllowed execute];
}

- (void) pushNotAllowedInSystem {
    NSLog(@"Checking | User has not allowed Remote Notifications in system");
    [self delPushDisabledOverall];
}

// MARK: KWSCheckAllowedProtocol

- (void) pushAllowedInKWS {
    NSLog(@"Checking | User is allowed to have Remote Notifications in KWS");
    [_kwsCheckRegistered execute];
}

- (void) pushNotAllowedInKWS {
    NSLog(@"Checking | User is not allowed to have Remote Notifications in KWS");
    [self delPushDisabledOverall];
}

- (void) checkAllowedError {
    NSLog(@"Error while checking if user is allowed to have Remote Notifications in KWS. Aborting.");
    [self delNetworkErrorTryingToCheckUserStatus];
}

// MARK: KWSCheckRegisteredProtocol

- (void) userIsRegistered {
    NSLog(@"Checking | User is registered to receive Remote Notifications in KWS");
    [self delPushAllowedOverall];
}

- (void) userIsNotRegistered {
    NSLog(@"Checking | User is not registered to receive Remote Notifications in KWS");
    [self delPushDisabledOverall];
}

- (void) checkRegisteredError {
    NSLog(@"Error while checking if user is registered for Remote Notifications in KWS");
    [self delNetworkErrorTryingToCheckUserStatus];
}

// MARK: Delegate functions

- (void) delPushAllowedOverall {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushAllowedOverall)]) {
        [_delegate pushAllowedOverall];
    }
}

- (void) delPushDisabledOverall {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushDisabledOverall)]) {
        [_delegate pushDisabledOverall];
    }
}

- (void) delNetworkErrorTryingToCheckUserStatus {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(networkErrorTryingToCheckUserStatus)]) {
        [_delegate networkErrorTryingToCheckUserStatus];
    }
}

@end
