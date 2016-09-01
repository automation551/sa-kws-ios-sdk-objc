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
        @"email": nullSafe(_emailAddress)
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    _invited (success && (status == 200 || status == 204));
}

- (void) execute:(NSString *)email :(invited)invited {
    _emailAddress = email;
    _invited = invited ? invited : ^(BOOL success) {};
    [super execute];
}

@end
