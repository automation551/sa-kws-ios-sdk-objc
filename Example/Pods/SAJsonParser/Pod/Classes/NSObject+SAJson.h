//
//  NSObject+SASerialization.h
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import <Foundation/Foundation.h>
#import "SADeserializationProtocol.h"
#import "SASerializationProtocol.h"

@interface NSObject (SAJson) <SADeserializationProtocol, SASerializationProtocol>
@end
