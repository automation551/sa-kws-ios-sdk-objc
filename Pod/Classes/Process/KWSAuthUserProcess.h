//
//  KWSAuthUserProcess.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import <Foundation/Foundation.h>

// create user status
typedef NS_ENUM(NSInteger, KWSChildrenLoginUserStatus) {
    KWSChildren_LoginUser_Success             = 0,
    KWSChildren_LoginUser_NetworkError        = 1,
    KWSChildren_LoginUser_InvalidCredentials  = 2
};

typedef void (^KWSChildrenLoginUserBlock)(KWSChildrenLoginUserStatus status);

@interface KWSAuthUserProcess : NSObject

- (void) authWithUsername:(NSString*)username
              andPassword:(NSString*)password
                         :(KWSChildrenLoginUserBlock)userAuthenticated;

@end
