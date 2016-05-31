//
//  KWSError.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSError.h"
#import "KWSInvalid.h"

@implementation KWSError

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        
        _code = [[jsonDictionary objectForKey:@"code"] integerValue];
        _codeMeaning = [jsonDictionary objectForKey:@"codeMeaning"];
        _errorMessage = [jsonDictionary objectForKey:@"errorMessage"];
        _invalid = [[KWSInvalid alloc] initWithJsonDictionary:[jsonDictionary objectForKey:@"invalid"]];
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"code": @(_code),
        @"codeMeaning": nullSafe(_codeMeaning),
        @"errorMessage": nullSafe(_errorMessage),
        @"invalid": nullSafe([_invalid dictionaryRepresentation])
    };
}

@end
