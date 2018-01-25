#import "KWSWebAuth.h"
#import <SafariServices/SafariServices.h>
#import "KWSChildren.h"
#import "SAUtils.h"
#import "KWSLoggedUser.h"
#import "KWSMetadata.h"
#import "OAuthHelper.h"

@interface KWSWebAuth () <SFSafariViewControllerDelegate>
@property (nonatomic, strong) SFSafariViewController *safariVC;
@property (nonatomic, strong) wauthenticated wauthenticated;
@property (nonatomic, strong) authCode authCode ;

@property (nonatomic, strong) NSString *codeChallenge;
@end

@implementation KWSWebAuth

- (NSString*) getEndpoint {
    return @"oauth";
}

- (NSDictionary*) getQuery {
    return @{
             @"clientId": nullSafe([[KWSChildren sdk] getClientId]),
             @"codeChallenge": nullSafe(_codeChallenge),
             @"codeChallengeMethod": CODE_CHALLENGE_METHOD,
             @"redirectUri": [NSString stringWithFormat:@"%@://", [[NSBundle mainBundle] bundleIdentifier]]
             };
}

- (id) init {
    
    if (self = [super init]) {
        _wauthenticated = ^(KWSLoggedUser* user, BOOL cancelled) {};
        _authCode = ^(NSString* authCode, BOOL cancelled) {};
    }
    
    
    return self;
}

- (void) execute:(NSString*) singleSignOnUrl
      withParent: (UIViewController*)parent
                :(wauthenticated) wauthenticated{
    
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

- (void) execute:(NSString*) singleSignOnUrl
withParentAuthCode: (UIViewController*)parent
andCodeChallenge: (NSString*) codeChallengeFromProcess
                :(authCode) authCode{
    
    //oauth start
    _codeChallenge = codeChallengeFromProcess;
    _authCode = authCode ? authCode: _authCode;
    
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
            
            NSString* urlAbsString = [url absoluteString];
            NSArray* arrayOfSubstrings = [urlAbsString componentsSeparatedByString:@"="];
            
            if(arrayOfSubstrings != nil && [arrayOfSubstrings count] >1){
                NSString *authCodeFromArray = [arrayOfSubstrings objectAtIndex:1];
                
                // stop the controller
                    [_safariVC dismissViewControllerAnimated:true completion:^{
                        //
                        // call the callback!
                        _authCode (authCodeFromArray,false);
                    }];
                
                
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
    //no valid auth code
    _authCode (nil,true);
    
    
    
    //
    // dismiss
    [controller dismissViewControllerAnimated:true completion:nil];
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    NSLog(@"Did load ok %d", didLoadSuccessfully);
}

@end
