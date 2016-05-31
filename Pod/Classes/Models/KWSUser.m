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
    if (self = [super initWithJsonDictionary:jsonDictionary]){
        
        _username = [jsonDictionary safeObjectForKey:@"username"];
        _firstName = [jsonDictionary safeObjectForKey:@"firstName"];
        _lastName = [jsonDictionary safeObjectForKey:@"lastName"];
        _email = [jsonDictionary safeObjectForKey:@"email"];
        _applicationPermissions = [[KWSPermissions alloc] initWithJsonDictionary:[jsonDictionary safeObjectForKey:@"applicationPermissions"]];
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
