//
//  KWSUnsubscribeToken.h
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import <Foundation/Foundation.h>

// unsubscribe toke protocol
@protocol KWSUnsubscribeTokenProtocol <NSObject>

- (void) tokenWasUnsubscribed;
- (void) tokenError;

@end

// unsubscribe token object
@interface KWSUnsubscribeToken : NSObject

// protocol
@property (nonatomic, weak) id<KWSUnsubscribeTokenProtocol> delegate;

// function
- (void) request: (NSString*)token;

@end
