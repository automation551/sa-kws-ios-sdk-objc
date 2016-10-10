//
//  KWSTokenResponse.m
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import "KWSAccessToken.h"

@implementation KWSAccessToken

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        
        _token_type = [jsonDictionary objectForKey:@"token_type"];
        _access_token = [jsonDictionary objectForKey:@"access_token"];
        _expires_in = [[jsonDictionary objectForKey:@"expires_in"] integerValue];
    }
    
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"token_type": nullSafe(_token_type),
        @"access_token": nullSafe(_access_token),
        @"expires_in": @(_expires_in)
    };
}

@end
