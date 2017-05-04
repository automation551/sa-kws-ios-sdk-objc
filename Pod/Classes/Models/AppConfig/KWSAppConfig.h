//
//  KWSAppConfig.h
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import <UIKit/UIKit.h>

//#if defined(__has_include)
//#if __has_include(<SAJsonParser/SAJsonParser.h>)
//#import <SAJsonParser/SAJsonParser.h>
//#else
//#import "SAJsonParser.h"
//#endif
//#endif

#import "SAJsonParser.h"
#import "SABaseObject.h"

@interface KWSAppConfig : SABaseObject <SASerializationProtocol, SADeserializationProtocol>
@property (nonatomic, assign) NSInteger _id;
@end
