#import "KWSWebAuth.h"
#import <SafariServices/SafariServices.h>
#import "KWSChildren.h"
#import "SAUtils.h"
#import "KWSLoggedUser.h"
#import "KWSMetadata.h"
#import <CommonCrypto/CommonCrypto.h>

@interface KWSWebAuth () <SFSafariViewControllerDelegate>
@property (nonatomic, strong) SFSafariViewController *safariVC;
@property (nonatomic, strong) wauthenticated wauthenticated;

//for OAuth
@property (nonatomic, strong) NSString *codeChallenge;
@property (nonatomic, strong) NSString *codeVerifier;
@end

@implementation KWSWebAuth

- (NSString*) getEndpoint {
    return @"oauth";
}

- (NSDictionary*) getQuery {
    return @{
             @"clientId": nullSafe([[KWSChildren sdk] getClientId]),
             @"codeChallenge": nullSafe(_codeChallenge),
             @"codeChallengeMethod": [self getCodeMethod],
             @"redirectUri": [NSString stringWithFormat:@"%@://", [[NSBundle mainBundle] bundleIdentifier]]
             };
}

- (NSString*) getCodeMethod {
    return @"S256";
}

- (NSString*) generateCodeChallenge: (NSString*) verifier {
    
    u_int8_t buffer[CC_SHA256_DIGEST_LENGTH * sizeof(u_int8_t)];
    memset(buffer, 0x0, CC_SHA256_DIGEST_LENGTH);
    NSData *data = [verifier dataUsingEncoding:NSUTF8StringEncoding];
    CC_SHA256([data bytes], (CC_LONG)[data length], buffer);
    NSData *hash = [NSData dataWithBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
    NSString *challenge = [[[[hash base64EncodedStringWithOptions:0]
                             stringByReplacingOccurrencesOfString:@"+" withString:@"-"]
                            stringByReplacingOccurrencesOfString:@"/" withString:@""]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
    
    return challenge;
}

static NSUInteger const kCodeVerifierBytes = 32;
- (nullable NSString *)randomURLSafeStringWithSize:(NSUInteger)size {
    NSMutableData *randomData = [NSMutableData dataWithLength:size];
    int result = SecRandomCopyBytes(kSecRandomDefault, randomData.length, randomData.mutableBytes);
    if (result != 0) {
        return nil;
    }
    return [self encodeBase64urlNoPadding:randomData];
}

- (NSString *)encodeBase64urlNoPadding:(NSData *)data {
    NSString *base64string = [data base64EncodedStringWithOptions:0];
    // converts base64 to base64url
    base64string = [base64string stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64string = [base64string stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    // strips padding
    base64string = [base64string stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return base64string;
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
    
    //oauth start
    _codeVerifier = [self randomURLSafeStringWithSize:kCodeVerifierBytes];
    _codeChallenge = [self generateCodeChallenge:_codeVerifier];
    
    
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
            
            /*THIS IS AN EXAMPLE
             po url - > org.cocoapods.demo.kwsiossdkobjc://?code=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjY2LCJjbGllbnRJZCI6InN0YW4tdGVzdCIsInNjb3BlIjoidXNlciIsImNvZGVDaGFsbGVuZ2UiOiI5ZTFlYzJjOTc3NDMzNDRiZWJhODhhNWZhZTYyNmI2ZDA5MDg5MjFjZGZlNjM4NzI2ZWFjMDljZjg2ZWNhMzViMTUwM2NlYWEzODRhOGYzODY5MTkkYjViZGExN2U5MGI2NzRiZCIsImNvZGVDaGFsbGVuZ2VNZXRob2QiOiI5ZTIyMjRiYiQ0OTU3YTg5MjNmZGFiMGRjIiwiaWF0IjoxNTE2ODE4NTQxLCJleHAiOjE1MTY4MTg2NjEsImlzcyI6InN1cGVyYXdlc29tZSJ9._nwu5-1IBAAnn-Vdi8KYwDYqhKbJ8NATHdpKb-roHrg
            
             FRAGMENT IS NULL. NEED TO PARSE THE STRING
             
             */
            
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
