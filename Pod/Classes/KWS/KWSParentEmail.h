//
//  KWSParentEmail.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// protocol
@protocol KWSParentEmailProtocol <NSObject>

- (void) emailSubmittedInKWS;
- (void) emailError;

@end

// class
@interface KWSParentEmail : NSObject

// delegate
@property (nonatomic, weak) id<KWSParentEmailProtocol> delegate;

// main func
- (void) submit:(NSString*)email;

@end
