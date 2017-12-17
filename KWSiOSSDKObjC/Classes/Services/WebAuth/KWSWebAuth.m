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
             @"redirectUri": nullSafe([NSString stringWithFormat:@"%@://", [[NSBundle mainBundle] bundleIdentifier]])
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
    
    //
    // form the endpoint
    NSString *endpoint = [self getEndpoint];
    NSString *query = [SAUtils formGetQueryFromDict:[self getQuery]];
    NSString *webViewUrlString = [NSString stringWithFormat:@"%@%@?%@", singleSignOnUrl, endpoint, query];
    NSURL *webViewUrl = [NSURL URLWithString:webViewUrlString];
    
    //
    // open the safari view controller
    _safariVC = [[SFSafariViewController alloc] initWithURL:webViewUrl];
    _safariVC.delegate = self;
    [parent presentViewController:_safariVC animated:true completion:nil];
}

- (void) openUrl:(NSURL *)url withOptions:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    //
    // get the potential source of the opening service
    NSString *source = [@"com.apple.SafariViewService" lowercaseString];
    
    //
    // get the value stored in the options dictionary
    UIApplicationOpenURLOptionsKey key = UIApplicationOpenURLOptionsSourceApplicationKey;
    id value = options[key];
    
    //
    // make sure this is opened by safari view service
    if (value != NULL && [[value lowercaseString] isEqualToString:source]) {
    
        //
        // get the scheme and the verify scheme (the bundle id of the app)
        NSString *scheme = [url scheme];
        NSString *verfScheme = [[NSBundle mainBundle] bundleIdentifier];
        
        //
        // if these match, we're good to go
        if (scheme != NULL && [[scheme lowercaseString] isEqualToString:[verfScheme lowercaseString]]) {
            
            //
            // get the fragment
            NSString *fragment = [url fragment];
            
            //
            // and if all is OK start parsing the fragment to get the token
            if (fragment != NULL) {
                
                NSArray *fragmentPieces = [fragment componentsSeparatedByString:@"="];
                if (fragmentPieces != NULL && [fragmentPieces count] >= 2) {
                    
                    //
                    // get the actual data
                    NSString *token = [fragmentPieces lastObject];
                    
                    //
                    // process metadata
                    KWSMetadata *metadata = [KWSMetadata processMetadata:token];
                    
                    //
                    // only go forward if the metadata is valid
                    if (metadata != NULL && [metadata isValid]) {
                        
                        //
                        // form the logged user
                        KWSLoggedUser *user = [[KWSLoggedUser alloc] init];
                        user.token = token;
                        user.metadata = metadata;
                        
                        //
                        // stop the controller
                        [_safariVC dismissViewControllerAnimated:true completion:^{
                            //
                            // call the callback!
                            _wauthenticated (user, false);
                        }];
                    }
                    //
                    // error case
                    else {
                        _wauthenticated (NULL, false);
                    }
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
    //
    // do nothing
}

@end
