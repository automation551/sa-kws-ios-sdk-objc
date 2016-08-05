//
//  KWSParentEmail.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSParentEmail.h"
#import "SAUtils.h"

@interface KWSParentEmail ()
@property (nonatomic, strong) submitted submitted;
@property (nonatomic, strong) NSString *emailToSubmit;
@end

@implementation KWSParentEmail

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
        _submitted(true);
    } else {
        _submitted(false);
    }
}

- (void) failure {
    _submitted(false);
}

- (void) execute:(NSString*)email :(submitted)submitted {
    // get callback
    _submitted = (submitted ? submitted : ^(BOOL success){});
    _emailToSubmit = email;
    
    // check parameter is actually valid
    if (_emailToSubmit == NULL || _emailToSubmit.length == 0 || [SAUtils isEmailValid:_emailToSubmit] == NULL) {
        _submitted(false);
        return;
    }
    
    // call to super
    [super execute:_emailToSubmit];
}

@end
