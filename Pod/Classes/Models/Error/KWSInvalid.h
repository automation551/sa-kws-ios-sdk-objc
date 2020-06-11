//
//  KWSInvalid.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@class KWSParentEmailError;

/**
 *  Object representing an Invalid parent email
 */
@interface KWSInvalid : KWSBaseObject <KWSDeserializationProtocol, KWSSerializationProtocol>

// Object representing an invalid parent email error
@property (nonatomic, strong) KWSParentEmailError *parentEmail;

@end
