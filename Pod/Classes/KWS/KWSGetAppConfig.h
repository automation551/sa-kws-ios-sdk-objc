//
//  KWSGetAppConfig.h
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import <Foundation/Foundation.h>
#import "KWSRequest.h"

@class KWSAppConfig;

@protocol KWSGetAppConfigProtocol <NSObject>

- (void) didGetAppConfig:(KWSAppConfig*) config;

@end


@interface KWSGetAppConfig : KWSRequest

@property (nonatomic, weak) id <KWSGetAppConfigProtocol> delegate;

- (void) execute;

@end
