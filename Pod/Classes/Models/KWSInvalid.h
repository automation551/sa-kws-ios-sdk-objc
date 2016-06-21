//
//  KWSInvalid.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "SAJsonParser.h"

@class KWSParentEmailError;

@interface KWSInvalid : SABaseObject <SADeserializationProtocol, SASerializationProtocol>
@property (nonatomic, strong) KWSParentEmailError *parentEmail;
@end
