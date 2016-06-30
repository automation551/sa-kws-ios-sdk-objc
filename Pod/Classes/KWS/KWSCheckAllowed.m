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
#import "KWSNetworking.h"
#import "KWSLogger.h"

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
        
        [KWSNetworking sendGET:endpoint token:oauthToken callback:^(NSString *json, NSInteger code) {
            
            if ((code == 200 || code == 204) && json != NULL) {
                
                KWSUser *user = [[KWSUser alloc] initWithJsonString:json];
                [KWSLogger log:[user jsonPreetyStringRepresentation]];
                
                if (user) {
                    
                    NSNumber *perm = user.applicationPermissions.sendPushNotification;
                    
                    if (perm == NULL || [perm boolValue] == true) {
                        [self delPushAllowedInKWS];
                    } else {
                        [self delPushNotAllowedInKWS];
                    }
                    
                } else {
                    [self delCheckError];
                }
            }
            else {
                [self delCheckError];
            }
        }];
    }
    else {
        [self delCheckError];
    }
    
}

// MARK: Delegate handler functions

- (void) delCheckError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(checkError)] ) {
        [_delegate checkError];
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
