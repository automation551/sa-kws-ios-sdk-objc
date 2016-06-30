//
//  KWSPermissions.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "SAJsonParser.h"

/**
 *  Represents a very basic KWS permission object, that only handles push 
 *  notification permissions
 */
@interface KWSPermissions : SABaseObject <SADeserializationProtocol, SASerializationProtocol>

// a NSNumber object holding either:
//  - NULL - means notifications are enabled (by default)
//  - true - means notifications are enabled (explicitly)
//  - false - means notifications are disabled (explicitly)
@property (nonatomic, strong) NSNumber *sendPushNotification;

@end
