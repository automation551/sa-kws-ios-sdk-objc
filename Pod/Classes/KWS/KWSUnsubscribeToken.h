//
//  KWSUnsubscribeToken.h
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//  @brief:
//  This module handles ubsubscribing a user's token from KWS.
//  

#import <Foundation/Foundation.h>
#import "KWSRequest.h"

// unsubscribe toke protocol
@protocol KWSUnsubscribeTokenProtocol <NSObject>

- (void) tokenWasUnsubscribed;
- (void) tokenUnsubscribeError;

@end

// unsubscribe token object
@interface KWSUnsubscribeToken : KWSRequest
// protocol
@property (nonatomic, weak) id<KWSUnsubscribeTokenProtocol> delegate;
@end
