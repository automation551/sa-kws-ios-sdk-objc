//
//  KWSLeader.h
//  Pods
//
//  Created by Gabriel Coman on 28/07/2016.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@interface KWSLeader : KWSBaseObject <KWSDeserializationProtocol, KWSSerializationProtocol>

@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong) NSString *user;

@end
