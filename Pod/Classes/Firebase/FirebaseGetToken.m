//
//  FirebaseGetToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

// header
#import "FirebaseGetToken.h"

// other imports
#import "Firebase.h"
#import "SALogger.h"

@interface FirebaseGetToken ()
@end

@implementation FirebaseGetToken

// MARK: Setup & Public functions

- (void) setup {
    
    @try {
        [FIRApp configure];
    } @catch (NSException *exception) {
        // when trying to configure an already configured app, it will throw
        // an exception, but it's not fatal - it's mostly a "warning", so
        // app execution should continue
        if ([FIRApp defaultApp] != NULL) {
            [SALogger log:@"Firebase app already exists"];
        }
        // when the configure function failed and there's no default app
        // already configured, then there trully is an error!
        else {
            [SALogger err:[NSString stringWithFormat:@"Could not configure Firebase %@", exception]];
            [self delDidFailBecauseFirebaseIsNotSetup];
         }
    } @finally {
        // do nothing
    }
    
    // get the token, if it exists
    NSString *token = [[FIRInstanceID instanceID] token];
    
    // if it does not, start the observer
    if (token == NULL) {
        [SALogger log:@"Starting observer for Firebase Token"];
        // Add observer for InstanceID token refresh callback.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tokenRefreshNotification:)
                                                     name:kFIRInstanceIDTokenRefreshNotification
                                                   object:nil];
    }
    // if it exists, use it
    else {
        [SALogger log:[NSString stringWithFormat:@"Getting already existing token %@", token]];
        [self delDidGetFirebaseToken:token];
    }
}

- (void) tokenRefreshNotification:(NSNotification *)notification {
    
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *token = [[FIRInstanceID instanceID] token];
    
    [SALogger log:[NSString stringWithFormat:@"Token is %@", token]];
    [self delDidGetFirebaseToken:token];
}

- (NSString*) getFirebaseToken {
    NSString *token = [[FIRInstanceID instanceID] token];
    return token;
}

// MARK: Delegate handler functions

- (void) delDidGetFirebaseToken:(NSString*) token {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didGetFirebaseToken:)]) {
        [_delegate didGetFirebaseToken:token];
    }
}

- (void) delFailToGetFirebaseToken {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailToGetFirebaseToken)]) {
        [_delegate didFailToGetFirebaseToken];
    }
}

- (void) delDidFailBecauseFirebaseIsNotSetup {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailBecauseFirebaseIsNotSetup)]) {
        [_delegate didFailBecauseFirebaseIsNotSetup];
    }
}

@end
