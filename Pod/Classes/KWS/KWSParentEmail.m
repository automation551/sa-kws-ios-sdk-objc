//
//  KWSParentEmail.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSParentEmail.h"

// aux
#import "KWS.h"
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSInvalid.h"

@implementation KWSParentEmail

// MARK: Main class function

- (void) submit:(NSString *)email {
    
    // validate
    if (![self validateEmail:email withStricterFilter:YES]){
        [self delEmailError];
    }
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata) {
        
        NSInteger userId = metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld/request-permissions", kwsApiUrl, (long)userId];
        NSDictionary *body = @{
                               @"permissions":@[@"sendPushNotification"],
                               @"parentEmail": email
                               };
        
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken]
                                 };
        
        SANetwork *network = [[SANetwork alloc] init];
        [network sendPOST:endpoint withQuery:@{} andHeader:header andBody:body andSuccess:^(NSInteger code, NSString *payload) {
            if (code == 200 || code == 204){
                [self delEmailSubmittedInKWS];
            } else {
                [self delEmailError];
            }
            
        } andFailure:^{
            [self delEmailError];
        }];
    }
    else {
        [self delEmailError];
    }
    
}

// MARK: Aux private functions

- (BOOL) validateEmail:(NSString*)email withStricterFilter:(BOOL) stricterFilter {
    if (!email || email.length == 0) {
        return false;
    }
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// MARK: Delegate handler functions

- (void) delEmailSubmittedInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(emailSubmittedInKWS)]) {
        [_delegate emailSubmittedInKWS];
    }
}

- (void) delEmailError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(emailError)]) {
        [_delegate emailError];
    }
}

@end
