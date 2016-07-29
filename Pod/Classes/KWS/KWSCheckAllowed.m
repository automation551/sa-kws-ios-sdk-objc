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

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld", (long)[metadata userId]];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    
    if ((status == 200 || status == 204) && payload != NULL) {
        
        KWSUser *user = [[KWSUser alloc] initWithJsonString:payload];
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
}

- (void) failure {
    [self delCheckAllowedError];
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
