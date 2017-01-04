//
//  KWSRandomNameManager.m
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import "KWSRandomNameManager.h"

// import KWS SDK
#import "KWS.h"

@interface KWSRandomNameManager () <KWSGetAppConfigProtocol>
@property (nonatomic, strong) KWSRandomName *randomName;
@property (nonatomic, strong) KWSGetAppConfig *appConfig;
@end

@implementation KWSRandomNameManager

- (id) init {
    if (self = [super init]) {
        _appConfig = [[KWSGetAppConfig alloc] init];
        _appConfig.delegate = self;
        _randomName = [[KWSRandomName alloc] init];
    }
    
    return self;
}

- (void) getRandomName {
    [_appConfig execute];
}

- (void) didGetAppConfig:(KWSAppConfig *)config {
    if (config != nil) {
        [_randomName execute:config._id :_delegate];
    }
    else {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(didGetRandomName:)]) {
            [_delegate didGetRandomName:nil];
        }
    }
}

@end
