#import <UIKit/UIKit.h>
#import "KWSService.h"

typedef void (^wauthenticated)(KWSLoggedUser *user, BOOL cancelled);

@interface KWSWebAuth: KWSService

- (void) execute:(NSString*) singleSignOnUrl
      withParent: (UIViewController*)parent
                :(wauthenticated) wauthenticated;
- (void) openUrl: (NSURL*) url
     withOptions: (NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end
