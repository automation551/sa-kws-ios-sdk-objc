//
//  KWSRandomNameManager.h
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import <Foundation/Foundation.h>

#import "KWSRandomName.h"
#import "KWSGetAppConfig.h"
#import "KWSAppConfig.h"

@interface KWSRandomNameManager : NSObject

@property (nonatomic, weak) id <KWSRandomNameProtocol> delegate;
- (void) getRandomName;
@end
