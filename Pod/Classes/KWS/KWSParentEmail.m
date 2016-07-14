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
    NSString *validatedEmail = [self returnValidatedEmailString:email withStricterFilter:true];
    if (validatedEmail == NULL) {
        [self delInvalidEmail];
        return;
    }
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    NSString *version = [[KWS sdk] getVersion];
    
    if (kwsApiUrl && oauthToken && metadata) {
        
        NSInteger userId = metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld/request-permissions", kwsApiUrl, (long)userId];
        NSDictionary *body = @{
                               @"permissions":@[@"sendPushNotification"],
                               @"parentEmail": validatedEmail};
        
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken],
                                 @"kws-sdk-version":version};
        
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

- (NSString*) returnValidatedEmailString:(NSString*)email withStricterFilter:(BOOL) stricterFilter {
    if (!email || email.length == 0) {
        return false;
    }
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSString *finalEmail = [email stringByReplacingOccurrencesOfString:@" " withString:@""];
    BOOL result = [emailTest evaluateWithObject:finalEmail];
    return (result ? finalEmail : NULL);
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

- (void) delInvalidEmail {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(invalidEmail)]) {
        [_delegate invalidEmail];
    }
}

@end
