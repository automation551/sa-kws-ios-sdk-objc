//
//  KWSCheckPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSCheckAllowed.h"

// aux
#import "KWS.h"
#import "SANetwork.h"
#import "SALogger.h"

// models
#import "KWSMetadata.h"
#import "KWSUser.h"
#import "KWSPermissions.h"

@implementation KWSCheckAllowed

// MARK: Main class function

- (void) check {
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata != NULL) {
        
        NSInteger userId = metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld", kwsApiUrl, (long)userId];
        
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken]
                                 };
        
        SANetwork *network = [[SANetwork alloc] init];
        [network sendGET:endpoint withQuery:@{} andHeader:header andSuccess:^(NSInteger code, NSString *json) {
            if ((code == 200 || code == 204) && json != NULL) {
                
                KWSUser *user = [[KWSUser alloc] initWithJsonString:json];
                [SALogger log:[user jsonPreetyStringRepresentation]];
                
                if (user) {
                    
                    NSNumber *perm = user.applicationPermissions.sendPushNotification;
                    
                    if (perm == NULL || [perm boolValue] == true) {
                        [self delPushAllowedInKWS];
                    } else {
                        [self delPushNotAllowedInKWS];
                    }
                    
                } else {
                    [self delCheckAllowedError];
                }
            }
            else {
                [self delCheckAllowedError];
            }
        } andFailure:^{
            [self delCheckAllowedError];
        }];
    } else {
        [self delCheckAllowedError];
    }
}

// MARK: Delegate handler functions

- (void) delCheckAllowedError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(checkAllowedError)] ) {
        [_delegate checkAllowedError];
    }
}

- (void) delPushNotAllowedInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushNotAllowedInKWS)]) {
        [_delegate pushNotAllowedInKWS];
    }
}

- (void) delPushAllowedInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushAllowedInKWS)]) {
        [_delegate pushAllowedInKWS];
    }
}

@end
