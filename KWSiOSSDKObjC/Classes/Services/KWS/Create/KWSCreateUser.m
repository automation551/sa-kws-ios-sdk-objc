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

@property (nonatomic, assign) NSInteger appId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString* parentEmail;

@end

@implementation KWSCreateUser

- (id) init {
    if (self = [super init]) {
        _created = ^(NSInteger status, KWSLoggedUser* user) {};
    }
    return self;
}

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/%ld/users?access_token=%@", (unsigned long)_appId, _token];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (BOOL) needsLoggedUser {
    return false;
}

- (NSDictionary*) getHeader {
    return @{
        @"Content-Type":@"application/json"
    };
}

- (NSDictionary*) getBody {
    return @{
        @"username": nullSafe(_username),
        @"password": nullSafe(_password),
        @"dateOfBirth": nullSafe(_dateOfBirth),
        @"country": nullSafe(_country),
        @"parentEmail": nullSafe(_parentEmail),
        @"authenticate": [NSNumber numberWithBool:true]
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    
    if (!success) {
        _created(status, nil);
    } else {
        if (status == 201 && payload != nil) {
            
            // create a new logged user that will have a proper OAuth token
            KWSLoggedUser *finalUser = [[KWSLoggedUser alloc] initWithJsonString:payload];
            
            // send signal
            _created (status, finalUser);
            
        } else {
            _created (status, nil);
        }
    }
}

- (void) executeWith:(NSString*)token
            andAppId:(NSInteger)appId
         andUsername:(NSString*)username
         andPassword:(NSString*)password
      andDateOfBirth:(NSString*)dateOfBirth
          andCountry:(NSString*)country
      andParentEmail:(NSString*)parentEmail
          onResponse:(created)created{
    
    _token = token;
    _appId = appId;
    _username = username;
    _password = password;
    _dateOfBirth = dateOfBirth;
    _country = country;
    _parentEmail = parentEmail;
    _created = created ? created : _created;
    
    [super execute];
    
}

@end
