//
//  NSDictionary+SAJsonExtension.m
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import "NSDictionary+SAJson.h"

@implementation NSDictionary (SAJson)

- (id) initWithJsonString:(NSString *)jsonString {
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    if (self = [self initWithJsonData:jsonData]) {
        
    }
    
    return self;
}

- (id) initWithJsonData:(NSData *)jsonData {
    
    NSError *error = NULL;
    NSDictionary *jsonDict = NULL;
    
    if (jsonData == NULL) return NULL;
    
    if (self = [self init]) {
        jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    }
    
    return jsonDict;
}

+ (NSDictionary*) dictionaryWithJsonString:(NSString*)jsonString {
    return [[NSDictionary alloc] initWithJsonString:jsonString];
}

+ (NSDictionary*) dictionaryWithJsonData:(NSData*)jsonData {
    return [[NSDictionary alloc] initWithJsonData:jsonData];
}

- (NSArray*) arrayForKey:(NSString*)key withIterator:(SAArrayIterator)iterator {
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray*)object;
        NSMutableArray *result = [@[] mutableCopy];
        
        for (id item in array) {
            [result addObject:iterator(item)];
        }
        
        return result;
    }
    return nil;
}

@end
