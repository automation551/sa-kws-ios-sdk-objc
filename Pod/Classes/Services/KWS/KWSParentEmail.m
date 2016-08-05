//
//  KWSParentEmail.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSParentEmail.h"

// aux
#import "KWS.h"
#import "SANetwork.h"
#import "SAUtils.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSInvalid.h"

@interface KWSParentEmail ()
@property (nonatomic, assign) submitted submitted;
@property (nonatomic, strong) NSString *emailToSubmit;
@end

@implementation KWSParentEmail

// MARK: Main class function

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld/request-permissions", (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"permissions": @[@"sendPushNotification"],
        @"parentEmail": _emailToSubmit
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    if (status == 200 || status == 204){
        [self delEmailSubmittedInKWS];
    } else {
        [self delEmailError];
    }
}

- (void) failure {
    [self delEmailError];
}

- (void) execute:(id)param :(submitted)submitted {
    // get parameter and check is correct type
    if ([param isKindOfClass:[NSString class]]) {
        _emailToSubmit = (NSString*)param;
    } else {
        [self delEmailError];
        return;
    }
    
    // get callback
    _submitted = submitted;
    
    // check parameter is actually valid
    if (_emailToSubmit == NULL || _emailToSubmit.length == 0 || [SAUtils isEmailValid:_emailToSubmit] == NULL) {
        [self delEmailError];
        return;
    }
    
    // call to super
    [super execute:param];
}

// MARK: Delegate handler functions

- (void) delEmailSubmittedInKWS {
    if (_submitted) {
        _submitted(true);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(emailSubmittedInKWS)]) {
//        [_delegate emailSubmittedInKWS];
//    }
}

- (void) delEmailError {
    if (_submitted) {
        _submitted(false);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(emailError)]) {
//        [_delegate emailError];
//    }
}

@end
