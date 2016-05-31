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
        _username = [jsonDictionary safeStringForKey:@"username"];
        _firstName = [jsonDictionary safeStringForKey:@"firstName"];
        _lastName = [jsonDictionary safeStringForKey:@"lastName"];
        _email = [jsonDictionary safeStringForKey:@"email"];
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
        @"applicationPermissions": nullSafe([_applicationPermissions dictionaryRepresentation])
    };
}

@end
