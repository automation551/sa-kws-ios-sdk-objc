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

- (void) request: (NSString*)token {
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata) {
        
        NSInteger userId = metadata.userId;
        NSInteger appId = metadata.appId;
        NSString *endpoint = [NSString stringWithFormat:@"%@apps/%ld/users/%ld/unsubscribe-push-notifications", kwsApiUrl, appId, userId];
        
        [KWSNetworking sendPOST:endpoint token:oauthToken body:@{} callback:^(NSString *json, NSInteger code) {
            
            if (code == 200) {
                NSLog(@"Payload ==> %@", json);
                [self delTokenWasUnsubscribed];
            } else {
                [self delTokenError];
            }
        }];
    }
    else {
        [self delTokenError];
    }
}

- (void) delTokenWasUnsubscribed {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasUnsubscribed)]){
        [_delegate tokenWasUnsubscribed];
    }
}

- (void) delTokenError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenError)]) {
        [_delegate tokenError];
    }
}

@end
