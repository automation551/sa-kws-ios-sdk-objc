//
//  FirebaseGetToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "FirebaseGetToken.h"
#import "Firebase.h"
#import "KWSLogger.h"
#import "Firebase.h"

#define MAXIMUM_NR_TIMES 30
#define FIREBASE_TOKEN @"FIREBASE_TOKEN"


@interface FirebaseGetToken ()
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) BOOL setupOK;
@end

@implementation FirebaseGetToken

// MARK: Setup & Public functions

- (void) setup {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _setupOK = true;
    
    @try {
        [FIRApp configure];
        [self request];
    } @catch (NSException *exception) {
        [KWSLogger err:@"Could not configure Firebase"];
        _setupOK = false;
        [self delDidFailBecauseFirebaseIsNotSetup];
    } @finally {
        // do nothing
    }
}

- (void) request {
    _times = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(internalTimerFunc) userInfo:nil repeats:YES];
}

- (void) internalTimerFunc {
    NSString *token = [[FIRInstanceID instanceID] token];
    
    if (token != NULL) {
        [KWSLogger log:[NSString stringWithFormat:@"Success in getting Firebase token after %ld tries", _times]];
        [_timer invalidate];
        _timer = nil;
        [_defaults setObject:token forKey:FIREBASE_TOKEN];
        [_defaults synchronize];
        [self delDidGetFirebaseToken:token];
    } else if (_times > MAXIMUM_NR_TIMES) {
        [KWSLogger err:[NSString stringWithFormat:@"Failed to get Firebase token after %ld tries", MAXIMUM_NR_TIMES]];
        [_timer invalidate];
        _timer = nil;
        [_defaults removeObjectForKey:FIREBASE_TOKEN];
        [_defaults synchronize];
        [self delFailToGetFirebaseToken];
    } else {
        _times++;
        [KWSLogger log:[NSString stringWithFormat:@"Trying to get Firebase token try %ld / %ld", _times, MAXIMUM_NR_TIMES]];
    }
}

- (NSString*) getFirebaseToken {
    if (_defaults == NULL) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return [_defaults objectForKey:FIREBASE_TOKEN];
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
