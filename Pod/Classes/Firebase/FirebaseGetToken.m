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

#define MAXIMUM_NR_TIMES 30

@interface FirebaseGetToken ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger times;
@end

@implementation FirebaseGetToken

- (void) request {
    
    // start firebase request
    _times = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(internalTimerFunc) userInfo:nil repeats:YES];
}

- (void) internalTimerFunc {
    NSString *token = [[FIRInstanceID instanceID] token];
    
    if (token != NULL) {
        [KWSLogger log:[NSString stringWithFormat:@"Success in getting Firebase token after %ld tries", _times]];
        [_timer invalidate];
        _timer = nil;
        [self delDidGetFirebaseToken:token];
    } else if (_times > MAXIMUM_NR_TIMES) {
        [KWSLogger err:[NSString stringWithFormat:@"Failed to get Firebase token after %ld tries", MAXIMUM_NR_TIMES]];
        [_timer invalidate];
        _timer = nil;
        [self delFailToGetFirebaseToken];
    } else {
        [KWSLogger log:[NSString stringWithFormat:@"Trying to get Firebase token try %ld / %ld", _times, MAXIMUM_NR_TIMES]];
    }
}

- (void) delDidGetFirebaseToken: (NSString*) token {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didGetFirebaseToken:)]) {
        [_delegate didGetFirebaseToken:token];
    }
}

- (void) delFailToGetFirebaseToken {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFailToGetFirebaseToken)]) {
        [_delegate didFailToGetFirebaseToken];
    }
}

@end
