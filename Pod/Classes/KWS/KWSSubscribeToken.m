//
//  KWSSubscribeToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "KWSSubscribeToken.h"

// aux
#import "KWS.h"
#import "KWSNetworking.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"

@implementation KWSSubscribeToken

- (void) request:(NSString*)token {
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata && token) {
        
        NSInteger userId = metadata.userId;
        NSInteger appId = metadata.appId;
        NSString *endpoint = [NSString stringWithFormat:@"%@apps/%ld/users/%ld/subscribe-push-notifications", kwsApiUrl, appId, userId];
        NSDictionary *body = @{@"token":token, @"platform": @"ios"};
        
        [KWSNetworking sendPOST:endpoint token:oauthToken body:body callback:^(NSString *json, NSInteger code) {
            
            if (code == 200 || code == 204) {
                NSLog(@"Payload ==> %@", json);
                [self delTokenWasSubscribed];
            } else {
                [self delTokenSubscribeError];
            }
        }];
    }
    else {
        [self delTokenSubscribeError];
    }
    
}

- (void) delTokenWasSubscribed {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasSubscribed)]) {
        [_delegate tokenWasSubscribed];
    }
}

- (void) delTokenSubscribeError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenSubscribeError)]) {
        [_delegate tokenSubscribeError];
    }
}

@end
