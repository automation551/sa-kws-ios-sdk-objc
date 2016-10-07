//
//  FirebaseGetToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

// header
#import "FirebaseGetToken.h"

// try and import Firebase, if present
#if defined(__has_include)
#if __has_include("Firebase.h")
#import "Firebase.h"
#endif
#endif

// other imports
#import "SALogger.h"

@interface FirebaseGetToken ()
@property (nonatomic, strong) gotToken gottoken;
@end

@implementation FirebaseGetToken

- (void) execute:(gotToken)gottoken {
    
    // call this
    _gottoken = gottoken ? gottoken : ^(BOOL success, NSString* token){};
    
    // get the main Firebase class (FIRApp)
    Class firebaseClass = NSClassFromString(@"FIRApp");
    
    // only execute this branch when Firebase is present
    if (firebaseClass != NULL) {
    
        @try {
            // try and call the "configure" method on "FIRApp"
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
            
            // when trying to configure an already configured app, it will throw
            // an exception, but it's not fatal - it's mostly a "warning", so
            // app execution should continue
            if (defaultApp != NULL) {
                [SALogger log:@"Firebase app already exists"];
            }
            // when the configure function failed and there's no default app
            // already configured, then there trully is an error!
            else {
                [SALogger err:[NSString stringWithFormat:@"Could not configure Firebase %@", exception]];
                _gottoken(false, nil);
            }
        } @finally {
            // do nothing
        }
        
        // get the token, if it exists
        NSString *token = [self tryAndGetToken];
        
        // if it does not, start the observer
        if (token == NULL) {
            [SALogger log:@"Starting observer for Firebase Token"];
            // Add observer for InstanceID token refresh callback.
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(tokenRefreshNotification:)
                                                         name:@"com.firebase.iid.notif.refresh-token" // kFIRInstanceIDTokenRefreshNotification
                                                       object:nil];
        }
        // if it exists, use it
        else {
            [SALogger log:[NSString stringWithFormat:@"Getting already existing token %@", token]];
            _gottoken(true, token);
        }
        
        // don't call super!
        // [super execute];
        
    } else {
        NSLog(@"Please make sure that Firebase is installed correctly!");
    }
}

- (void) tokenRefreshNotification:(NSNotification *)notification {
    
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *token = [self tryAndGetToken];
    
    [SALogger log:[NSString stringWithFormat:@"Token is %@", token]];
    if (token != NULL) {
        _gottoken(true, token);
    }
}

- (NSString*) getSavedToken {
    // get the main Firebase class (FIRApp)
    Class firebaseClass = NSClassFromString(@"FIRApp");
    
    if (firebaseClass) {
        
        @try {
            // try and call the "configure" method on "FIRApp"
            if ([firebaseClass respondsToSelector:@selector(configure)]) {
                [firebaseClass performSelector:@selector(configure)];
            }
        } @catch (NSException* ignored) {
            // do nothing
        }
        
        // return the token
        return [self tryAndGetToken];
    }
    else {
        return nil;
    }
}

- (NSString*) tryAndGetToken {
    // get a Class object for FIRInstanceID
    Class FIRInstanceIDClass = NSClassFromString(@"FIRInstanceID");
    
    // get an actual instance, since FIRInstanceID is a singleton
    id instance = NULL;
    if ([FIRInstanceIDClass respondsToSelector:@selector(instanceID)]) {
        instance = [FIRInstanceIDClass performSelector:@selector(instanceID)];
    }
    
    // finally try to get the Token
    NSString *token = NULL;
    if ([instance respondsToSelector:@selector(token)]) {
        token = [instance performSelector:@selector(token)];
    }
    
    return token;
}


@end
