//
//  KWSUserCreateDetail.h
//  Pods
//
//  Created by Gabriel Coman on 07/10/2016.
//
//

#import <UIKit/UIKit.h>
#import "SAJsonParser.h"

@interface KWSUserCreateDetail : SABaseObject
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *token;
@end
