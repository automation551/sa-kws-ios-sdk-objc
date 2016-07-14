//
//  KWSCheckRegistered.m
//  Pods
//
//  Created by Gabriel Coman on 14/07/2016.
//
//

// header
#import "KWSCheckRegistered.h"

// aux
#import "KWS.h"
#import "SANetwork.h"
#import "SALogger.h"

// models
#import "KWSMetadata.h"
#import "KWSUser.h"
#import "KWSPermissions.h"

@implementation KWSCheckRegistered

// MARL: Main function

- (void) check {
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata != NULL) {
        
        NSInteger userId = metadata.userId;
        NSInteger appId = metadata.appId;
        NSString *endpoint = [NSString stringWithFormat:@"%@apps/%ld/users/%ld/has-device-token", kwsApiUrl, appId, userId];
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken]
                                 };
        
        SANetwork *network = [[SANetwork alloc] init];
        [network sendGET:endpoint withQuery:@{} andHeader:header andSuccess:^(NSInteger status, NSString *payload) {
            
            if ([payload isEqualToString:@"true"]) {
                [self delUserIsRegistered];
            } else if ([payload isEqualToString:@"false"]) {
                [self delUserIsNotRegistered];
            } else {
                [self delCheckRegisteredError];
            }
        } andFailure:^{
            [self delCheckRegisteredError];
        }];
        
    } else {
        [self delCheckRegisteredError];
    }
}

// MARK: Delegates

- (void) delUserIsRegistered {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(userIsRegistered)]) {
        [_delegate userIsRegistered];
    }
}

- (void) delUserIsNotRegistered {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(userIsNotRegistered)]) {
        [_delegate userIsNotRegistered];
    }
}

- (void) delCheckRegisteredError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(checkRegisteredError)]) {
        [_delegate checkRegisteredError];
    }
}

@end
