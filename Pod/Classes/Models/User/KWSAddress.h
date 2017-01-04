//
//  KWSAddress.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import <Foundation/Foundation.h>

//#if defined(__has_include)
//#if __has_include(<SAJsonParser/SAJsonParser.h>)
//#import <SAJsonParser/SAJsonParser.h>
//#else
//#import "SAJsonParser.h"
//#endif
//#endif

#import "SAJsonParser.h"

@interface KWSAddress : SABaseObject <SASerializationProtocol, SADeserializationProtocol>

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *country;

@end
