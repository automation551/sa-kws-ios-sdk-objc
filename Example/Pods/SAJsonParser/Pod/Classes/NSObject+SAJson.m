//
//  NSObject+SASerialization.m
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import "NSObject+SAJson.h"
#import "NSDictionary+SAJson.h"

@implementation NSObject (SAJson)

// deserialization

- (id) initWithJsonDictionary:(NSDictionary*)jsonDictionary{
    if (self = [self init]){
        
    }
    return self;
}

- (id) initWithJsonString:(NSString*)jsonString {
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithJsonString:jsonString];
    if (self = [self initWithJsonDictionary:jsonDictionary]) {
        
    }
    return self;
}

- (id) initWithJsonData:(NSData*)jsonData {
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithJsonData:jsonData];
    if (self = [self initWithJsonDictionary:jsonDictionary]) {
        
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

// serialization

- (NSDictionary*) dictionaryRepresentation {
    return @{};
}

- (NSString*) jsonPreetyStringRepresentation {
    NSDictionary *dictionary = [self dictionaryRepresentation];
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSData *json = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString*) jsonCompactStringRepresentation {
    NSDictionary *dictionary = [self dictionaryRepresentation];
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSData *json = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
        return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSData*) jsonDataRepresentation {
    NSDictionary *dictionary = [self dictionaryRepresentation];
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        return [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
    }
    return nil;
}

@end
