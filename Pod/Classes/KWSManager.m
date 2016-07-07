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
//@property (nonatomic, strong) PushCheckRegistered *pushCheckRegistered;
//@property (nonatomic, strong) PushRegister *pushRegister;
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
        _kwsCheckAllowed = [[KWSCheckAllowed alloc] init];
//        _pushRegister = [[PushRegister alloc] init];
//        _pushCheckRegistered = [[PushCheckRegistered alloc] init];
        _kwsRequestPermission = [[KWSRequestPermission alloc] init];
    }
    return self;
}

// MARL: Public function

- (void) checkIfNotificationsAreAllowed {
    [SALogger log:@"Checking to see if Push Notificactions are allowed"];
    _pushCheckAllowed.delegate = self;
    [_pushCheckAllowed check];
}

// MARK: PushCheckAllowedProtocol

- (void) pushAllowedInSystem {
    [SALogger log:@"Push Notifications enabled on user system"];
    _kwsCheckAllowed.delegate = self;
    [_kwsCheckAllowed check];
}

- (void) pushNotAllowedInSystem {
    [SALogger err:@"Push Notifications disabled on user system"];
    [self delPushNotAllowedInSystem];
    // unsubscribe (optional, maybe?)
}


// MARK: KWSCheckAllowedProtocol

- (void) pushAllowedInKWS {
    [SALogger log:@"Push Notifications enabled for user in KWS"];
    
    _kwsRequestPermission.delegate = self;
    [_kwsRequestPermission request];
//    
//    _pushCheckRegistered.delegate = self;
//    [_pushCheckRegistered isRegistered]; // THIS SHOULD NOT BE HERE
}

- (void) pushNotAllowedInKWS {
    [SALogger err:@"Push Notifications disabled for user in KWS"];
//    [_pushRegister unregisterPush]; // nok here
    [self delPushNotAllowedInKWS]; // nok here
}

- (void) checkError {
    [SALogger err:@"An unknown network error occured"];
    [self delNetworkError];
}

//// MARK: PushCheckRegisteredProtocol
//// THESE SHOULD BE DELETED
//- (void) isRegisteredInSystem {
//    [SALogger log:@"User has already registered for Push Notifications"];
//    [self delIsAlreadyRegistered];
//}
//
//- (void) isNotRegisteredInSystem {
//    [SALogger log:@"User is not yet registered for Push Notificaitons, starting request"];
//    
//}

// MARK: KWSRequestPermissionProtocol

- (void) pushPermissionRequestedInKWS {
    [SALogger log:@"Was able to request new Push Notification permissions in KWS"];
    [self delIsAllowedToRegister];
}

- (void) parentEmailIsMissingInKWS {
    [SALogger err:@"Was not able to request new Push Notificaiton permissions in KWS (parent email missing)"];
    [self delParentEmailIsMissingInKWS];
}

- (void) requestError {
    [SALogger err:@"An unknown network error occured"];
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

//- (void) delIsAlreadyRegistered {
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(isAlreadyRegistered)]) {
//        [_delegate isAlreadyRegistered];
//    }
//}

@end
