//
//  KWSCheckPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSCheckPermission.h"

// aux
#import "KWS.h"
#import "KWSNetworking.h"
#import "NSObject+StringToModel.h"
#import "NSObject+ModelToString.h"

// models
#import "KWSMetadata.h"
#import "KWSUser.h"
#import "KWSPermissions.h"

@implementation KWSCheckPermission

- (void) check {
    
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    
    if (kwsApiUrl && oauthToken && metadata != NULL) {
        
        NSInteger userId = metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld", kwsApiUrl, (long)userId];
        
        [KWSNetworking sendGET:endpoint token:oauthToken callback:^(NSString *json, NSInteger code) {
            
            if ((code == 200 || code == 204) && json != NULL) {
                
                KWSUser *user = [[KWSUser alloc] initModelFromJsonString:json andOptions:Strict];
                NSLog(@"User data: %@", [user jsonStringPreetyRepresentation] );
                
                if (user) {
                    
                    NSNumber *perm = user.applicationPermissions.sendPushNotification;
                    
                    if (perm == NULL || [perm boolValue] == true) {
                        [self delPushEnabledInKWS];
                    } else {
                        [self delPushDisabledInKWS];
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

- (void) delCheckError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(checkError)] ) {
        [_delegate checkError];
    }
}

- (void) delPushDisabledInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushDisabledInKWS)]) {
        [_delegate pushDisabledInKWS];
    }
}

- (void) delPushEnabledInKWS {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushEnabledInKWS)]) {
        [_delegate pushEnabledInKWS];
    }
}

@end
