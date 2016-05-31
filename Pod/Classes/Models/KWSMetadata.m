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
        _userId = [jsonDictionary safeIntForKey:@"userId"];
        _appId = [jsonDictionary safeIntForKey:@"appId"];
        _clientId = [jsonDictionary safeIntForKey:@"clientId"];
        _scope = [jsonDictionary safeStringForKey:@"scope"];
        _iat = [jsonDictionary safeIntForKey:@"iat"];
        _exp = [jsonDictionary safeIntForKey:@"exp"];
        _iss = [jsonDictionary safeStringForKey:@"iss"];
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
