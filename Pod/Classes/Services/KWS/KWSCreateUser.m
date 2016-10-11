//
//  KWSCreateUser.m
//  Pods
//
//  Created by Gabriel Coman on 07/10/2016.
//
//

#import "KWSCreateUser.h"

// created user model
#import "KWSLoggedUser.h"

@interface KWSCreateUser ()
@property (nonatomic, strong) created created;
@property (nonatomic, strong) KWSLoggedUser *loggedUser;
@end

@implementation KWSCreateUser

- (id) init {
    if (self = [super init]) {
        _created = ^(NSInteger status, KWSLoggedUser* loggedUser) {};
    }
    return self;
}

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/%ld/users?access_token=%@", _loggedUser.metadata.appId, _loggedUser.accessToken];
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
        @"username": nullSafe(_loggedUser.username),
        @"password": nullSafe(_loggedUser.password),
        @"dateOfBirth": nullSafe(_loggedUser.dateOfBirth),
        @"country": nullSafe(_loggedUser.country),
        @"parentEmail": nullSafe(_loggedUser.parentEmail),
        @"authenticate": [NSNumber numberWithBool:true]
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    
    if (!success) {
        _created(status, nil);
    } else {
        if (status == 201 && payload != nil) {
            
            // create a new logged user that will have a proper OAuth token
            KWSLoggedUser *loggedUser = [[KWSLoggedUser alloc] initWithJsonString:payload];
            
            // if all is OK go forward
            if (loggedUser && loggedUser.token) {
                _created(status, loggedUser);
            } else {
                _created(status, nil);
            }
        } else {
            _created(status, nil);
        }
    }
}

- (void) executeWithCreatedUser:(KWSLoggedUser*)loggedUser
                               : (created) created {
    
    // get variables
    _created = created ? created : _created;
    _loggedUser = loggedUser;
    
    // do some validation
    
    [super execute];
    
}

@end
