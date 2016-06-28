//
//  KWSSubscribeToken.h
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import <Foundation/Foundation.h>

// subscribe token protocol
@protocol KWSSubscribeTokenProtocol <NSObject>

- (void) tokenWasSubscribed;
- (void) tokenError;

@end

// subscribe token class
@interface KWSSubscribeToken : NSObject

// delegate
@property (nonatomic, weak) id<KWSSubscribeTokenProtocol> delegate;

// standard function
- (void) request:(NSString*)token;

@end
