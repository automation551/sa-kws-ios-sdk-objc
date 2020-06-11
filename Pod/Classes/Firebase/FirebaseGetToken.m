//
//  FirebaseGetToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

// header
#import "FirebaseGetToken.h"
#import "KWSUtils.h"

// other imports
#if defined(__has_include)
#if __has_include(<Firebase/Firebase.h>)
#import <Firebase/Firebase.h>
#endif
#endif

@interface FirebaseGetToken ()
@end

@implementation FirebaseGetToken

// MARK: Setup & Public functions

- (void) setup {
    
    
    Class firebaseClass = NSClassFromString(@"FIRApp");
    
    if (firebaseClass != NULL) {
        
        @try {
            if ([firebaseClass respondsToSelector:@selector(configure)]) {
                [firebaseClass performSelector:@selector(configure)];
            }
        } @catch (NSException *exception) {
            // when trying to configure an already configured app, it will throw
            // an exception, but it's not fatal - it's mostly a "warning", so
            // app execution should continue
            id defaultApp = NULL;
            if ([firebaseClass respondsToSelector:@selector(defaultApp)]) {
                defaultApp = [firebaseClass performSelector:@selector(defaultApp)];
            }
            
            if (defaultApp != NULL) {
                NSLog(@"Firebase app already exists");
            }
            // when the configure function failed and there's no default app
            // already configured, then there trully is an error!
            else {
                NSLog(@"Could not configure Firebase %@", exception);
                [self delDidFailBecauseFirebaseIsNotSetup];
            }
        } @finally {
            // do nothing
        }
        
        // get the token, if it exists
        NSString *token = [self tryAndGetToken];
        
        // if it does not, start the observer
        if (token == NULL) {
            NSLog(@"Starting observer for Firebase Token");
            // Add observer for InstanceID token refresh callback.
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(tokenRefreshNotification:)
                                                         name:@"com.firebase.iid.notif.refresh-token" // kFIRInstanceIDTokenRefreshNotification
                                                       object:nil];
        }
        // if it exists, use it
        else {
            NSLog(@"Getting already existing token %@", token);
            [self delDidGetFirebaseToken:token];
        }
        
    } else {
        NSLog(@"Please make sure that Firebase is installed correctly!");
    }
    
}

- (void) tokenRefreshNotification:(NSNotification *)notification {
    NSString *token = [self tryAndGetToken];
    NSLog(@"Token is %@", token);
    [self delDidGetFirebaseToken:token];
}

- (NSString*) getFirebaseToken {
    return [self tryAndGetToken];
}

- (NSString*) tryAndGetToken {
    Class FIRInstanceIDClass = NSClassFromString(@"FIRInstanceID");
    id instance = NULL;
    if ([FIRInstanceIDClass respondsToSelector:@selector(instanceID)]) {
        instance = [FIRInstanceIDClass performSelector:@selector(instanceID)];
    }
    
    NSString *token = NULL;
    if ([instance respondsToSelector:@selector(token)]) {
        token = [instance performSelector:@selector(token)];
    }
    
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
