//
//  KWSModel.m
//  KWSiOSSDKObjC
//
//  Created by Gabriel Coman on 07/07/2016.
//  Copyright © 2016 Gabriel Coman. All rights reserved.
//

#import "KWSModel.h"

@implementation KWSModel

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        _status = [[jsonDictionary safeObjectForKey:@"status"] integerValue];
        _userId = [[jsonDictionary safeObjectForKey:@"userId"] integerValue];
        _token = [jsonDictionary safeObjectForKey:@"token"];
        _username = [jsonDictionary safeObjectForKey:@"username"];
        _error = [jsonDictionary safeObjectForKey:@"error"];
    }
    
    return self;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"status": @(_status),
        @"userId": @(_userId),
        @"username": nullSafe(_username),
        @"error": nullSafe(_error),
        @"token": nullSafe(_token)
    };
}

@end
