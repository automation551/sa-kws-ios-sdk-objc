//
//  KWSInvalid.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

@class KWSError;

@interface KWSInvalid : NSObject
@property (nonatomic, strong) KWSError *parentEmail;
@end
