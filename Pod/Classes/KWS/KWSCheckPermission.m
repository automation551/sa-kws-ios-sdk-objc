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
    
    if ([KWS sdk].kwsApiUrl != NULL && [KWS sdk].oauthToken != NULL && [KWS sdk].metadata != NULL) {
        
        NSInteger userId = [KWS sdk].metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld", [KWS sdk].kwsApiUrl, (long)userId];
        
        [KWSNetworking sendGET:endpoint token:[KWS sdk].oauthToken callback:^(NSString *json, NSInteger code) {
            
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
