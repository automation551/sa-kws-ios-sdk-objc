//
//  NSArray+SAJson.m
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import "NSArray+SAJson.h"

@implementation NSArray (SAJson)

- (NSArray*) arrayIterator:(SAArrayIterator)iterator {
    NSMutableArray *result = [@[] mutableCopy];
    for (id item in self) {
        [result addObject:iterator(item)];
    }
    return result;
}

@end
