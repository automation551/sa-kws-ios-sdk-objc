//
//  KWSCheckRegistered.h
//  Pods
//
//  Created by Gabriel Coman on 14/07/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSRequest.h"

// protocol
@protocol KWSCheckRegisteredProtocol <NSObject>

- (void) userIsRegistered;
- (void) userIsNotRegistered;
- (void) checkRegisteredError;

@end

// class
@interface KWSCheckRegistered : KWSRequest
// delegate
@property (nonatomic, weak) id<KWSCheckRegisteredProtocol> delegate;
@end
