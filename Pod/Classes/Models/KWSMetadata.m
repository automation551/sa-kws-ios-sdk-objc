//
//  Metadata.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSMetadata.h"

@implementation KWSMetadata

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super init]) {
        _userId = [[jsonDictionary objectForKey:@"userId"] integerValue];
        _appId = [[jsonDictionary objectForKey:@"appId"] integerValue];
        _clientId = [[jsonDictionary objectForKey:@"clientId"] integerValue];
        _scope = [jsonDictionary objectForKey:@"scope"];
        _iat = [[jsonDictionary objectForKey:@"iat"] integerValue];
        _exp = [[jsonDictionary objectForKey:@"exp"] integerValue];
        _iss = [jsonDictionary objectForKey:@"iss"];
    }
    
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"userId": @(_userId),
        @"appId": @(_appId),
        @"clientId": @(_clientId),
        @"scope": nullSafe(_scope),
        @"iat": @(_iat),
        @"exp": @(_exp),
        @"iss": nullSafe(_iss)
    };
}

@end
