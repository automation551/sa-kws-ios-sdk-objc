//
//  KWSCheckPermission.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

// protocol

@protocol KWSCheckPermissionProtocol <NSObject>

- (void) pushEnabledInKWS;
- (void) pushDisabledInKWS;
- (void) checkError;

@end

// class

@interface KWSCheckPermission : NSObject

// delegate
@property (nonatomic, weak) id<KWSCheckPermissionProtocol> delegate;

// main func
- (void) check;

@end
