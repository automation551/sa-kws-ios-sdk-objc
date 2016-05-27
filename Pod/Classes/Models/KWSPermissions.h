//
//  KWSPermissions.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>
#import "SAJsonParser.h"

@interface KWSPermissions : NSObject <SADeserializationProtocol, SASerializationProtocol>
@property (nonatomic, strong) NSNumber *sendPushNotification;
@end
