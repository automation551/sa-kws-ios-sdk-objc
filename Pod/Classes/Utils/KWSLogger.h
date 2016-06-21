//
//  KWSLogger.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

@interface KWSLogger : NSObject

+ (void) log:(NSString*)message;
+ (void) err:(NSString*)message;

@end
