//
//  NSObject+SASerialization.h
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import <Foundation/Foundation.h>

static id nullSafe(id object) {
    return object ?: [NSNull null];
}

@protocol SASerializationProtocol <NSObject>

// custom init functions
@required
- (NSDictionary*) dictionaryRepresentation;
@optional
- (NSString*) jsonPreetyStringRepresentation;
- (NSString*) jsonCompactStringRepresentation;
- (NSData*) jsonDataRepresentation;

@end
