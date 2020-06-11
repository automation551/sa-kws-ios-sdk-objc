//
//  KWSPermissions.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

/**
 *  Represents a very basic KWS permission object, that only handles push 
 *  notification permissions
 */
@interface KWSPermissions : KWSBaseObject <KWSDeserializationProtocol, KWSSerializationProtocol>

// a NSNumber object holding either:
//  - NULL - means notifications are enabled (by default)
//  - true - means notifications are enabled (explicitly)
//  - false - means notifications are disabled (explicitly)
@property (nonatomic, strong) NSNumber *accessAddress;
@property (nonatomic, strong) NSNumber *accessPhoneNumber;
@property (nonatomic, strong) NSNumber *accessFirstName;
@property (nonatomic, strong) NSNumber *accessLastName;
@property (nonatomic, strong) NSNumber *accessEmail;
@property (nonatomic, strong) NSNumber *accessStreetAddress;
@property (nonatomic, strong) NSNumber *accessCity;
@property (nonatomic, strong) NSNumber *accessPostalCode;
@property (nonatomic, strong) NSNumber *accessCountry;
@property (nonatomic, strong) NSNumber *sendPushNotification;
@property (nonatomic, strong) NSNumber *sendNewsletter;

@end
