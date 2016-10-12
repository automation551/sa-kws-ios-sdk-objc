//
//  KWSAuthUser.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import "KWSAuthUser.h"
#import "KWSLoggedUser.h"
#import "KWS.h"

@interface KWSAuthUser ()
@property (nonatomic, strong) authenticated authenticated;
@property (nonatomic, strong) KWSLoggedUser *loggedUser;
@end

@implementation KWSAuthUser

- (id) init {
    if (self = [super init]) {
        _authenticated = ^(NSInteger status, KWSLoggedUser* loggedUser) {};
    }
    return self;
}

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"oauth/authorise?access_token=%@", _loggedUser.accessToken];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getHeader {
    return @{
        @"Content-Type":@"application/json"
    };
}

- (NSDictionary*) getBody {
    return @{
        @"response_type": @"token",
        @"client_id": nullSafe([[KWS sdk] getClientId]),
        @"redirect_uri": nullSafe([NSString stringWithFormat:@"%@:/", [[NSBundle mainBundle] bundleIdentifier]])
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _authenticated(status, nil);
    } else {
        if (status == 200 && payload != nil) {
            
            // create a new logged user that will have a proper OAuth token
            KWSLoggedUser *loggedUser = [[KWSLoggedUser alloc] initWithJsonString:payload];
            
            // if all is OK go forward
            if (loggedUser && loggedUser.token) {
                _authenticated(status, loggedUser);
            } else {
                _authenticated(status, nil);
            }
        } else {
            _authenticated(status, nil);
        }
    }
}

- (void) executeWithUser:(KWSLoggedUser *)user :(authenticated)authenticated {
    _authenticated = authenticated ? authenticated : _authenticated;
    _loggedUser = user;
    [super execute];
}

@end