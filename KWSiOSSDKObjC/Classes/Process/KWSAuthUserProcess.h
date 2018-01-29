//
//  KWSAuthUserProcess.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import <UIKit/UIKit.h>

// create user status
typedef NS_ENUM(NSInteger, KWSChildrenLoginUserStatus) {
    KWSChildren_LoginUser_Success             = 0,
    KWSChildren_LoginUser_NetworkError        = 1,
    KWSChildren_LoginUser_InvalidCredentials  = 2,
    KWSChildren_LoginUser_Cancelled           = 3
};

typedef void (^KWSChildrenLoginUserBlock)(KWSChildrenLoginUserStatus status);

@interface KWSAuthUserProcess : NSObject

- (void) authWithUsername:(NSString*)username
              andPassword:(NSString*)password
                         :(KWSChildrenLoginUserBlock)userAuthenticated;

- (void) authWithSingleSignOnUrl:(NSString*) url
                      fromParent:(UIViewController*) parent
                                :(KWSChildrenLoginUserBlock)userAuthenticated;

- (void) openUrl: (NSURL*) url
     withOptions: (NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

- (void) authUser:(NSString *)authCode
              url:(NSString *)url
       fromParent:(UIViewController *)parent
 withCodeVerifier:(NSString *)codeVerifier
                 :(KWSChildrenLoginUserBlock)userAuthenticated;


@end
