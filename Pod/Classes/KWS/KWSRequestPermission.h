//
//  KWSRequestPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module is concerned with send a request for a new permission to KWS,
//  namely for the Remote Notification permission
//
//  If all goes well the user is granted the new permission
//  If the user does not have a parent email, then that's an error case
//

#import <UIKit/UIKit.h>

// protocol
@protocol KWSRequestPermissionProtocol <NSObject>

- (void) pushPermissionRequestedInKWS;
- (void) parentEmailIsMissingInKWS;
- (void) permissionError;

@end

// class
@interface KWSRequestPermission : NSObject

// delegate
@property (nonatomic, weak) id<KWSRequestPermissionProtocol> delegate;

// main function
- (void) request;

@end
