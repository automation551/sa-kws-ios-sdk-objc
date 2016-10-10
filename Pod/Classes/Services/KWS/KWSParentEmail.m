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
    return [NSString stringWithFormat:@"v1/users/%ld/request-permissions", (long)loggedUser.metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"permissions": @[@"sendPushNotification"],
        @"parentEmail": nullSafe(_emailToSubmit)
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    _submitted (success && (status == 204 || status == 200));
}

- (void) execute:(NSString*)email :(submitted)submitted {
    // get callback
    _submitted = submitted ? submitted : ^(BOOL success){};
    _emailToSubmit = email;
    
    // check parameter is actually valid
    if (_emailToSubmit == NULL || _emailToSubmit.length == 0 || [SAUtils isEmailValid:_emailToSubmit] == false) {
        _submitted(false);
        return;
    }
    
    // call to super
    [super execute:_emailToSubmit];
}

@end
