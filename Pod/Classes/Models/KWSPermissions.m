//
//  KWSPermissions.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSPermissions.h"

@implementation KWSPermissions

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super init]){
        _sendPushNotification = [jsonDictionary objectForKey:@"sendPushNotification"];
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"sendPushNotification": nullSafe(_sendPushNotification)
    };
}

@end
