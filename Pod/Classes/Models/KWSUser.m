//
//  User.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSUser.h"
#import "KWSPermissions.h"

@implementation KWSUser

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super init]){
        _username = [jsonDictionary objectForKey:@"username"];
        _firstName = [jsonDictionary objectForKey:@"firstName"];
        _lastName = [jsonDictionary objectForKey:@"lastName"];
        _email = [jsonDictionary objectForKey:@"email"];
        _applicationPermissions = [[KWSPermissions alloc] initWithJsonDictionary:[jsonDictionary objectForKey:@"applicationPermissions"]];
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"username": nullSafe(_username),
        @"firstName": nullSafe(_firstName),
        @"lastName": nullSafe(_lastName),
        @"email": nullSafe(_email),
        @"applicationPermissions": [_applicationPermissions dictionaryRepresentation]
    };
}

@end
