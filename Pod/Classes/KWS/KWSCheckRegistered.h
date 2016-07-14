//
//  KWSCheckRegistered.h
//  Pods
//
//  Created by Gabriel Coman on 14/07/2016.
//
//

#import <Foundation/Foundation.h>

// protocol
@protocol KWSCheckRegisteredProtocol <NSObject>

- (void) userIsRegistered;
- (void) userIsNotRegistered;
- (void) checkRegisteredError;

@end

// class
@interface KWSCheckRegistered : NSObject

// delegate
@property (nonatomic, weak) id<KWSCheckRegisteredProtocol> delegate;

// main function
- (void) check;

@end
