//
//  NSDictionary+SAJsonExtension.h
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import <Foundation/Foundation.h>

typedef id (^SAArrayIterator)(id item);

@interface NSDictionary (SAJson)

// custom inits
- (id) initWithJsonString:(NSString*)jsonString;
- (id) initWithJsonData:(NSData*)jsonData;
+ (NSDictionary*) dictionaryWithJsonString:(NSString*)jsonString;
+ (NSDictionary*) dictionaryWithJsonData:(NSData*)jsonData;

// other dict functions
- (NSArray*) arrayForKey:(NSString*)key withIterator:(SAArrayIterator)iterator;

@end
