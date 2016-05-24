//
//  KWSLogger.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSLogger.h"

@implementation KWSLogger

+ (void) log:(NSString*)message {
    NSLog(@"[KWS] :: Log ==> %@", message);
}

+ (void) err:(NSString*)message {
    NSLog(@"[KWS] :: Err ==> %@", message);
}

@end
