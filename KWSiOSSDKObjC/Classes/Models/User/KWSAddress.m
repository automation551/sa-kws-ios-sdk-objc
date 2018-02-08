//
//  KWSAddress.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import "KWSAddress.h"

@implementation KWSAddress

- (id) initWithStreet:(NSString*)street andCity:(NSString*) city andPostCode:(NSString*) postCode
           andCountry: (NSString*) country{
    
    self = [super init];
    
    _street = street;
    _city = city;
    _postCode = postCode;
    _country = country;
    
    return self;
}

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]){
        _street = [jsonDictionary safeObjectForKey:@"street"];
        _city = [jsonDictionary safeObjectForKey:@"city"];
        _postCode = [jsonDictionary safeObjectForKey:@"postCode"];
        _country = [jsonDictionary safeObjectForKey:@"country"];
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"street": nullSafe(_street),
        @"city": nullSafe(_city),
        @"postCode": nullSafe(_postCode),
        @"country": nullSafe(_country)
    };
}

@end
