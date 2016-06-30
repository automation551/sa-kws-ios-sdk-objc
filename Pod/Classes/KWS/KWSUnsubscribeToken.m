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
#import "KWSNetworking.h"

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
    
    if (kwsApiUrl && oauthToken && metadata && token) {
        
        NSInteger userId = metadata.userId;
        NSInteger appId = metadata.appId;
        NSString *endpoint = [NSString stringWithFormat:@"%@apps/%ld/users/%ld/unsubscribe-push-notifications", kwsApiUrl, appId, userId];
        
        [KWSNetworking sendPOST:endpoint token:oauthToken body:@{@"token":token} callback:^(NSString *json, NSInteger code) {
            
            if (code == 200 || code == 204) {
                NSLog(@"Payload ==> %@", json);
                [self delTokenWasUnsubscribed];
            } else {
                [self delTokenUnsubscribeError];
            }
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
