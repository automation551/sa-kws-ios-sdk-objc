//
//  KWSInvalid.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>
#import "SAJsonParser.h"

@class KWSParentEmailError;

@interface KWSInvalid : NSObject <SADeserializationProtocol, SASerializationProtocol>
@property (nonatomic, strong) KWSParentEmailError *parentEmail;
@end
