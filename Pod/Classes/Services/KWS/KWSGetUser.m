//
//  KWSGetUser.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import "KWSGetUser.h"

@interface KWSGetUser ()
@property (nonatomic, strong) gotUser gotuser;
@end

@implementation KWSGetUser

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld", (long)[metadata userId]];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _gotuser(nil);
    } else {
        if ((status == 200 || status == 204) && payload != NULL) {
            KWSUser *user = [[KWSUser alloc] initWithJsonString:payload];
            _gotuser(user);
        }
        else {
            _gotuser(nil);
        }
    }
}

- (void) execute:(gotUser)gotuser {
    _gotuser = (gotuser ? gotuser : ^(KWSUser*user){});
    [super execute];
}

@end
