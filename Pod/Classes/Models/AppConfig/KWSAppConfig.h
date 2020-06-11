//
//  KWSAppConfig.h
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@interface KWSAppConfig : KWSBaseObject <KWSSerializationProtocol, KWSDeserializationProtocol>
@property (nonatomic, assign) NSInteger _id;
@end
