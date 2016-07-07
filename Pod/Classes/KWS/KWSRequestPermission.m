//
//  KWSRequestPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSRequestPermission.h"

// aux
#import "KWS.h"
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"

@implementation KWSRequestPermission

- (void) request {
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata) {
        
        NSInteger userId = metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld/request-permissions", kwsApiUrl, (long)userId];
        NSDictionary *body = @{@"permissions":@[@"sendPushNotification"]};
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken]
                                 };
        
        
        SANetwork *network = [[SANetwork alloc] init];
        [network sendPOST:endpoint withQuery:@{} andHeader:header andBody:body andSuccess:^(NSInteger code, NSString *json) {
            if (json) {
                KWSError *error = [[KWSError alloc] initWithJsonString:json];
                NSLog(@"%@", [error jsonPreetyStringRepresentation]);
                
                if (code == 200 || code == 204) {
                    [self delPushPermissionRequestedInKWS];
                }
                else if (code != 200 && error) {
                    if (error.code == 5 && error.invalid.parentEmail.code == 6) {
                        [self delParentEmailIsMissingInKWS];
                    }
                    else {
                        [self delRequestError];
                    }
                }
                else {
                    [self delRequestError];
                }
            } else {
                [self delRequestError];
            }
        } andFailure:^{
            [self delRequestError];
        }];
    }
    else {
        [self delRequestError];
    }
    
}

- (void) delPushPermissionRequestedInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushPermissionRequestedInKWS)]) {
        [_delegate pushPermissionRequestedInKWS];
    }
}

- (void) delParentEmailIsMissingInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(parentEmailIsMissingInKWS)]) {
        [_delegate parentEmailIsMissingInKWS];
    }
}

- (void) delRequestError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(requestError)]) {
        [_delegate requestError];
    }
}

@end
