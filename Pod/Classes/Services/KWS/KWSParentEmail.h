//
//  KWSParentEmail.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module is used to send a parent email to the KWS backend
//

#import <UIKit/UIKit.h>
#import "KWSRequest.h"

// protocol
@protocol KWSParentEmailProtocol <NSObject>

- (void) emailSubmittedInKWS;
- (void) emailError;
- (void) invalidEmail;

@end

// callback
typedef void (^submitted)(BOOL success);

@interface KWSParentEmail : KWSRequest
// delegate
@property (nonatomic, weak) id<KWSParentEmailProtocol> delegate;

- (void) execute:(id)param :(submitted)submitted;
@end
