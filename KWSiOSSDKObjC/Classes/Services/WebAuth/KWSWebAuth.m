#import "KWSWebAuth.h"
#import <SafariServices/SafariServices.h>
#import "KWSChildren.h"
#import "SAUtils.h"
#import "KWSLoggedUser.h"
#import "KWSMetadata.h"

@interface KWSWebAuth () <SFSafariViewControllerDelegate>
@property (nonatomic, strong) SFSafariViewController *safariVC;
@property (nonatomic, strong) wauthenticated wauthenticated;
@end

@implementation KWSWebAuth

- (NSString*) getEndpoint {
    return @"oauth";
}

- (NSDictionary*) getQuery {
    return @{
             @"clientId": nullSafe([[KWSChildren sdk] getClientId]),
             @"redirectUri": [NSString stringWithFormat:@"%@://", [[NSBundle mainBundle] bundleIdentifier]]
             };
}

- (id) init {
    
    if (self = [super init]) {
        _wauthenticated = ^(KWSLoggedUser* user, BOOL cancelled) {};
    }
    
    return self;
}

- (void) execute:(NSString*) singleSignOnUrl
      withParent: (UIViewController*)parent
                :(wauthenticated) wauthenticated {
    
    //
    // save this!
    _wauthenticated = wauthenticated ? wauthenticated : _wauthenticated;
    
    NSString *endpoint = [self getEndpoint];
    NSString *query = [SAUtils formGetQueryFromDict:[self getQuery]];
    NSString *webViewUrlString = [NSString stringWithFormat:@"%@%@?%@", singleSignOnUrl, endpoint, query];
    NSURL *webViewUrl = [NSURL URLWithString:webViewUrlString];
    
    _safariVC = [[SFSafariViewController alloc] initWithURL:webViewUrl];
    _safariVC.delegate = self;
    [parent presentViewController:_safariVC animated:true completion:nil];
}

- (void) openUrl:(NSURL *)url withOptions:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    UIApplicationOpenURLOptionsKey key = UIApplicationOpenURLOptionsSourceApplicationKey;
    NSString *source = [@"com.apple.SafariViewService" lowercaseString];
    id value = options[key];
    
    if (value != NULL && [[value lowercaseString] isEqualToString:source]) {
    
        NSString *scheme = [url scheme];
        NSString *verfScheme = [[NSBundle mainBundle] bundleIdentifier];
        
        if (scheme != NULL && [[scheme lowercaseString] isEqualToString:[verfScheme lowercaseString]]) {
            NSString *fragment = [url fragment];
            
            if (fragment != NULL) {
                NSArray *fragmentPieces = [fragment componentsSeparatedByString:@"="];
                if (fragmentPieces != NULL && [fragmentPieces count] >= 2) {
                    NSString *token = [fragmentPieces lastObject];
                    KWSLoggedUser *user = [[KWSLoggedUser alloc] init];
                    user.token = token;
                    user.metadata = [KWSMetadata processMetadata:user.token];
                    
                    //
                    // stop the controller
                    [_safariVC dismissViewControllerAnimated:true completion:^{
                        //
                        // call the callback!
                        _wauthenticated (user, false);
                    }];
                }
            }
        }
    }
}

//
// SFSafariViewControllerDelegate

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
    //
    // call this
    _wauthenticated (nil, true);
    
    //
    // dismiss
    [controller dismissViewControllerAnimated:true completion:nil];
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    NSLog(@"Did load ok %d", didLoadSuccessfully);
}

@end
