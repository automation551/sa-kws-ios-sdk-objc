//
//  KWSCreatedUser.m
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import "KWSLoggedUser.h"
#import "KWSMetadata.h"
#import "KWSAux.h"

@implementation KWSLoggedUser

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        
        __id = [[jsonDictionary safeObjectForKey:@"id"] integerValue];
        _username = [jsonDictionary safeObjectForKey:@"username"];
        _password = [jsonDictionary safeObjectForKey:@"password"];
        _parentEmail = [jsonDictionary safeObjectForKey:@"parentEmail"];
        _country = [jsonDictionary safeObjectForKey:@"country"];
        _accessToken = [jsonDictionary safeObjectForKey:@"access_token"];
        _token = [jsonDictionary safeObjectForKey:@"token"];
        _dateOfBirth = [jsonDictionary safeObjectForKey:@"dateOfBirth"];
        _metadata = [KWSAux processMetadata:_accessToken];
    }
    
    return self;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"id": @(__id),
        @"username": nullSafe(_username),
        @"password": nullSafe(_password),
        @"parentEmail": nullSafe(_parentEmail),
        @"country": nullSafe(_country),
        @"access_token": nullSafe(_accessToken),
        @"token": nullSafe(_token),
        @"dateOfBirth": nullSafe(_dateOfBirth),
        @"metadata": nullSafe([_metadata dictionaryRepresentation])
    };
}

// TODO: this has to be better
- (BOOL) isValid {
    return true;
}

@end
