//
//  KWSParentEmailError.m
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import "KWSParentEmailError.h"

@implementation KWSParentEmailError

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super init]) {
        _code = [[jsonDictionary objectForKey:@"code"] integerValue];
        _errorMessage = [jsonDictionary objectForKey:@"errorMessage"];
        _codeMeaning = [jsonDictionary objectForKey:@"codeMeaning"];
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"code": @(_code),
        @"errorMessage": nullSafe(_errorMessage),
        @"codeMeaning": nullSafe(_codeMeaning)
    };
}

@end
