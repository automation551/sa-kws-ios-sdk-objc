//
//  User.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "SAJsonParser.h"

@class KWSPermissions;

/**
 *  Represents a basic user profile in KWS
 */
@interface KWSUser : SABaseObject <SASerializationProtocol, SADeserializationProtocol>

// username (unique)
@property (nonatomic, strong) NSString *username;

// first name
@property (nonatomic, strong) NSString *firstName;

// last name
@property (nonatomic, strong) NSString *lastName;

// email address of user
@property (nonatomic, strong) NSString *email;

// permissions granted by KWS
@property (nonatomic, strong) KWSPermissions *applicationPermissions;

@end
