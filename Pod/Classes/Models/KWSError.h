//
//  KWSError.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>
#import "SAJsonParser.h"

@class KWSInvalid;

@interface KWSError : SABaseObject <SASerializationProtocol, SADeserializationProtocol>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *codeMeaning;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) KWSInvalid *invalid;
@end
