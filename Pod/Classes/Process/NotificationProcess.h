//
//  NotificationProcess.h
//  Pods
//
//  Created by Gabriel Coman on 05/08/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSErrorType.h"

// define blocks for the notification process
typedef void (^isRegistered)(BOOL success);
typedef void (^registered)(BOOL success, KWSErrorType type);
typedef void (^unregistered)(BOOL success);

@interface NotificationProcess : NSObject

@end
