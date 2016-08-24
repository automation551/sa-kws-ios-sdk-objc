//
//  KWSInviteUser.m
//  Pods
//
//  Created by Gabriel Coman on 24/08/2016.
//
//

#import "KWSInviteUser.h"

@interface KWSInviteUser ()
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) invited invited;
@end

@implementation KWSInviteUser

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld/invite-user", (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"emailAddress": nullSafe(_emailAddress)
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _invited (false);
    } else {
        if (status == 200 || status == 204) {
            _invited (true);
        } else {
            _invited (false);
        }
    }
}

- (void) execute:(NSString *)email :(invited)invited {
    _emailAddress = email;
    _invited = invited ? invited : ^(BOOL success) {};
    [super execute];
}

@end
