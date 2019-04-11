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
#if defined(__has_include)
#if __has_include(<SANetwork/SANetwork.h>)
#import <SANetwork/SANetwork.h>
#else
#import "SANetwork.h"
#endif
#endif

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"

@implementation KWSRequestPermission

// MARK: Main functions

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/users/%ld/request-permissions", (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"permissions": @[
            @"sendPushNotification"
        ]
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    if (payload) {
        KWSError *error = [[KWSError alloc] initWithJsonString:payload];
        NSLog(@"%@", [error jsonPreetyStringRepresentation]);
        
        if (status == 200 || status == 204) {
            [self delPushPermissionRequestedInKWS];
        }
        else if (status != 200 && error) {
            if (error.code == 10 && error.invalid.parentEmail.code == 6) {
                [self delParentEmailIsMissingInKWS];
            }
            else {
                [self delPermissionErrorError];
            }
        }
        else {
            [self delPermissionErrorError];
        }
    } else {
        [self delPermissionErrorError];
    }
}

- (void) failure {
    [self delPermissionErrorError];
}

// MARK Delegate functions

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

- (void) delPermissionErrorError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(permissionError)]) {
        [_delegate permissionError];
    }
}

@end
