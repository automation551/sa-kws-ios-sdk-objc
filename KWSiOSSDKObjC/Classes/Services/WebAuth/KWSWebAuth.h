#import <UIKit/UIKit.h>
#import "KWSService.h"

typedef void (^wauthenticated)(KWSLoggedUser *user, BOOL cancelled);
typedef void (^authCode)(NSString *authCode,BOOL cancelled);

@interface KWSWebAuth: KWSService

- (void) execute:(NSString*) singleSignOnUrl
      withParent: (UIViewController*)parent
                :(wauthenticated) wauthenticated;

- (void) execute:(NSString*) singleSignOnUrl
withParentAuthCode: (UIViewController*)parent
andCodeChallenge: (NSString*) codeChallengeFromProcess
andCodeChallengeMethod: (NSString*) codeChallengeMethodFromProcess
                :(authCode) authCode;

- (void) openUrl: (NSURL*) url
     withOptions: (NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end
