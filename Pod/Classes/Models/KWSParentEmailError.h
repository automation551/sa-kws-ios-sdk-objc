//
//  KWSParentEmailError.h
//  Pods
//
//  Created by Gabriel Coman on 27/05/2016.
//
//

#import <Foundation/Foundation.h>
#import "SAJsonParser.h"

@interface KWSParentEmailError : NSObject <SADeserializationProtocol, SASerializationProtocol>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *codeMeaning;
@property (nonatomic, strong) NSString *errorMessage;
@end
