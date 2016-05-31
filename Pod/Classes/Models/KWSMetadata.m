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
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        
        _userId = [[jsonDictionary safeObjectForKey:@"userId"] integerValue];
        _appId = [[jsonDictionary safeObjectForKey:@"appId"] integerValue];
        _clientId = [[jsonDictionary safeObjectForKey:@"clientId"] integerValue];
        _scope = [jsonDictionary safeObjectForKey:@"scope"];
        _iat = [[jsonDictionary safeObjectForKey:@"iat"] integerValue];
        _exp = [[jsonDictionary safeObjectForKey:@"exp"] integerValue];
        _iss = [jsonDictionary safeObjectForKey:@"iss"];
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
