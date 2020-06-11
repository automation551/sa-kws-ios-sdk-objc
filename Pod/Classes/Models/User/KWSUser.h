//
//  User.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@class KWSPermissions;
@class KWSAddress;
@class KWSPoints;
@class KWSApplicationProfile;

/**
 *  Represents a basic user profile in KWS
 */
@interface KWSUser : KWSBaseObject <KWSSerializationProtocol, KWSDeserializationProtocol>

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) KWSAddress *address;
@property (nonatomic, strong) KWSPoints *points;
@property (nonatomic, strong) KWSPermissions *applicationPermissions;
@property (nonatomic, strong) KWSApplicationProfile *applicationProfile;

@end
