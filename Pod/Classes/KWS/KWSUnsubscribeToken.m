//
//  KWSUnsubscribeToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "KWSUnsubscribeToken.h"

// aux
#import "KWS.h"
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"

@implementation KWSUnsubscribeToken

// MARK: Main Functions

- (void) request: (NSString*)token {
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    NSString *version = [[KWS sdk] getVersion];
    
    if (kwsApiUrl && oauthToken && metadata && token) {
        
        NSInteger userId = metadata.userId;
        NSInteger appId = metadata.appId;
        NSString *endpoint = [NSString stringWithFormat:@"%@apps/%ld/users/%ld/unsubscribe-push-notifications", kwsApiUrl, appId, userId];
        NSDictionary *body = @{@"token":token};
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken],
                                 @"kws-sdk-version":version};

        SANetwork *network = [[SANetwork alloc] init];
        [network sendPOST:endpoint withQuery:@{} andHeader:header andBody:body andSuccess:^(NSInteger code, NSString *json) {
            NSLog(@"Payload ==> %@", json);
            [self delTokenWasUnsubscribed];
        } andFailure:^{
            [self delTokenUnsubscribeError];
        }];
    }
    else {
        [self delTokenUnsubscribeError];
    }
}

// MARK: Delegate handler functions

- (void) delTokenWasUnsubscribed {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasUnsubscribed)]){
        [_delegate tokenWasUnsubscribed];
    }
}

- (void) delTokenUnsubscribeError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenUnsubscribeError)]) {
        [_delegate tokenUnsubscribeError];
    }
}

@end
