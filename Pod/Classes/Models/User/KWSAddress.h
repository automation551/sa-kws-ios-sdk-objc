//
//  KWSAddress.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@interface KWSAddress : KWSBaseObject <KWSSerializationProtocol, KWSDeserializationProtocol>

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *country;

@end
