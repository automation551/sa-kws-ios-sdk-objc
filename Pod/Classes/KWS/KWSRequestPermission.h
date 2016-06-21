//
//  KWSRequestPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

// protocol
@protocol KWSRequestPermissionProtocol <NSObject>

- (void) pushPermissionRequestedInKWS;
- (void) parentEmailIsMissingInKWS;
- (void) requestError;

@end

// class
@interface KWSRequestPermission : NSObject

// delegate
@property (nonatomic, weak) id<KWSRequestPermissionProtocol> delegate;

// main function
- (void) request;

@end
