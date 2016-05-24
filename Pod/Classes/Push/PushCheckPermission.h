//
//  PushCheckPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

// protocol
@protocol PushCheckPermissionProtocol <NSObject>

- (void) pushEnabledInSystem;
- (void) pushDisabledInSystem;

@end

// class
@interface PushCheckPermission : NSObject

// delegate
@property (nonatomic, weak) id<PushCheckPermissionProtocol> delegate;

// main funciton
- (void) check;
- (void) markSystemDialogAsSeen;

@end
