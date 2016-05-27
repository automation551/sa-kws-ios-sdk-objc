//
//  NSArray+SAJson.h
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import <Foundation/Foundation.h>

typedef id (^SAArrayIterator)(id item);

@interface NSArray (SAJson)

- (NSArray*) arrayIterator:(SAArrayIterator)iterator;

@end