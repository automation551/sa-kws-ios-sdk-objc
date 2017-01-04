//
//  KWSCreatedUser.m
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import "KWSLoggedUser.h"
#import "KWSMetadata.h"

@interface KWSLoggedUser ()
@property (nonatomic, assign) BOOL isRegisteredForRM;
@end

@implementation KWSLoggedUser

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        _token = [jsonDictionary safeObjectForKey:@"token"];
        _isRegisteredForRM = [jsonDictionary safeBoolForKey:@"isRegisteredForRM"];
        _metadata = [KWSMetadata processMetadata:_token];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _token = [aDecoder decodeObjectForKey:@"token"];
        _isRegisteredForRM = [aDecoder decodeBoolForKey:@"isRegisteredForRM"];
        _metadata = [aDecoder decodeObjectForKey:@"metadata"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeBool:_isRegisteredForRM forKey:@"isRegisteredForRM"];
    [aCoder encodeObject:_metadata forKey:@"metadata"];
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"token": nullSafe(_token),
        @"isRegisteredForRM": @(_isRegisteredForRM),
        @"metadata": nullSafe([_metadata dictionaryRepresentation])
    };
}

- (BOOL) isValid {
    return _token != nil && _metadata != nil && [_metadata isValid];
}


- (void) setIsRegisteredForNotifications:(BOOL) value {
    _isRegisteredForRM = value;
}

- (BOOL) isRegisteredForNotifications {
    return _isRegisteredForRM;
}

@end
