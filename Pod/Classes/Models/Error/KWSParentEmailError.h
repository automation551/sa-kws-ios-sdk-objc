//
//  KWSParentEmailError.h
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

/**
 *  Error object describing an invalid error; It has much in common with the
 *  KWSError object
 */
@interface KWSParentEmailError : KWSBaseObject <KWSDeserializationProtocol, KWSSerializationProtocol>

// error code
@property (nonatomic, assign) NSInteger code;

// error meaning
@property (nonatomic, strong) NSString *codeMeaning;

// error message
@property (nonatomic, strong) NSString *errorMessage;

@end
