//
//  KWSRandomNameProcess.m
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import "KWSRandomNameProcess.h"

@interface KWSRandomNameProcess ()
@property (nonatomic, strong) KWSGetAppConfig *getAppConfig;
@property (nonatomic, strong) KWSRandomName *randomName;
@end

@implementation KWSRandomNameProcess

- (id) init {
    if (self = [super init]) {
        _getAppConfig = [[KWSGetAppConfig alloc] init];
        _randomName = [[KWSRandomName alloc] init];
    }
    return self;
}

- (void) getRandomName: (KWSChildrenGetRandomUsernameBlock) gotRandomName {
    
    [_getAppConfig execute:^(KWSAppConfig *config) {
       
        // if the config is returned valid
        if (config != nil) {
            
            // finally get the random name
            [_randomName execute:config._id onResult:gotRandomName];
            
        }
        // if the config isn't valid, then return a nil random name
        else {
            
            if (gotRandomName) {
                gotRandomName (nil);
            }
            
        }
        
    }];
    
}

@end
