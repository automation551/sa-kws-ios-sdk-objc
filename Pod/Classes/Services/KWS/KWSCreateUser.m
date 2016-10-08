//
//  KWSCreateUser.m
//  Pods
//
//  Created by Gabriel Coman on 07/10/2016.
//
//

#import "KWSCreateUser.h"
#import "KWSUserCreateDetail.h"
#import "SANetwork.h"

@interface KWSCreateUser ()
@property (nonatomic, strong) created created;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) SANetwork *network;
@end

@implementation KWSCreateUser

- (NSString*) getEndpoint {
    return @"https://kwsdemobackend.herokuapp.com/create";
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
        @"username": nullSafe(_username),
        @"password": nullSafe(_password),
        @"dateOfBirth": nullSafe(_dateOfBirth),
        @"country": nullSafe(_country)
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    
    if (!success) {
        _created(false, nil);
    } else {
        if (status == 200 && payload != nil) {
            KWSUserCreateDetail *details = [[KWSUserCreateDetail alloc] initWithJsonString:payload];
            if (details.token) {
                _created(true, details.token);
            } else {
                _created(false, nil);
            }
        } else {
            _created(false, nil);
        }
    }
    
}

- (void) execute:(NSString *)username
     andPassword:(NSString *)password
  andDateOfBirth:(NSString *)dateOfBirth
      andCountry:(NSString *)country
                :(created)created {
    _created = created ? created : ^(BOOL success, NSString* token) {};
    _username = username;
    _password = password;
    _dateOfBirth = dateOfBirth;
    _country = country;
    // [super execute];
    
    // safe block self
    __block id blockSelf = self;
    
    _network = [[SANetwork alloc] init];
    [_network sendPOST:[NSString stringWithFormat:@"%@", [self getEndpoint]]
             withQuery:[self getQuery]
             andHeader:[self getHeader]
               andBody:[self getBody]
          withResponse:^(NSInteger status, NSString *payload, BOOL success) {
              [blockSelf successWithStatus:(int)status andPayload:payload andSuccess:success];
          }];
}


@end
