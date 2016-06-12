//
//  User.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>
#import "SAJsonParser.h"

@class KWSPermissions;

@interface KWSUser : SABaseObject <SASerializationProtocol, SADeserializationProtocol>
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) KWSPermissions *applicationPermissions;
@end
