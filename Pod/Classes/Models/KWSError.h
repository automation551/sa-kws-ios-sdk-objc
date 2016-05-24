//
//  KWSError.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

@class KWSInvalid;

@interface KWSError : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *codeMeaning;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) KWSInvalid *invalid;
@end
