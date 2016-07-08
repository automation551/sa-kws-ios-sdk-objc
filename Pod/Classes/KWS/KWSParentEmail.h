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

// protocol
@protocol KWSParentEmailProtocol <NSObject>

- (void) emailSubmittedInKWS;
- (void) emailError;
- (void) invalidEmail;

@end

// delegate
@interface KWSParentEmail : NSObject

// delegate
@property (nonatomic, weak) id<KWSParentEmailProtocol> delegate;

/**
 *  Main class function
 *
 *  @param email a valid email string
 */
- (void) submit:(NSString*)email;

@end
