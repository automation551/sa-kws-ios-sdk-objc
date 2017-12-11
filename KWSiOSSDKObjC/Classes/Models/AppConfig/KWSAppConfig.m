//
//  KWSAppConfig.m
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import "KWSAppConfig.h"

@implementation KWSAppConfig

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        
        NSDictionary *app = [jsonDictionary safeObjectForKey:@"app"];
        if (app) {
            __id = [app safeIntForKey:@"id"];
        }
    }
    
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
             @"app": @{
                     @"id": @(__id)
                     }
             };
}

@end
