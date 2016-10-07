//
//  KWSUserCreateDetail.m
//  Pods
//
//  Created by Gabriel Coman on 07/10/2016.
//
//

#import "KWSUserCreateDetail.h"

@implementation KWSUserCreateDetail

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        _status = [[jsonDictionary safeObjectForKey:@"status"] integerValue];
        _userId = [[jsonDictionary safeObjectForKey:@"userId"] integerValue];
        _token = [jsonDictionary safeObjectForKey:@"token"];
    }
    
    return self;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"status": @(_status),
        @"userId": @(_userId),
        @"token": nullSafe(_token),
    };
}


@end
