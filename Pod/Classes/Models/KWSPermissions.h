//
//  KWSPermissions.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "SAJsonParser.h"

@interface KWSPermissions : SABaseObject <SADeserializationProtocol, SASerializationProtocol>
@property (nonatomic, strong) NSNumber *sendPushNotification;
@end
