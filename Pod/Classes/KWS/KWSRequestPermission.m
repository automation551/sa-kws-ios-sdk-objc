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
#import "KWSNetworking.h"
#import "NSObject+StringToModel.h"
#import "NSObject+ModelToString.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSInvalid.h"

@implementation KWSRequestPermission

- (void) request {
    
    if ([KWS sdk].kwsApiUrl != NULL && [KWS sdk].oauthToken != NULL && [KWS sdk].metadata != NULL) {
        
        NSInteger userId = [KWS sdk].metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld/request-permissions", [KWS sdk].kwsApiUrl, (long)userId];
        NSDictionary *body = @{@"permissions":@[@"sendPushNotification"]};
        
        [KWSNetworking sendPOST:endpoint token:[KWS sdk].oauthToken body:body callback:^(NSString *json, NSInteger code) {
            
            if (json) {
                KWSError *error = [[KWSError alloc] initModelFromJsonString:json andOptions:Strict];
                NSLog(@"%@", [error jsonStringPreetyRepresentation]);
                
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
        }];
    }
    else {
        [self delRequestError];
    }
    
}

- (void) delPushPermissionRequestedInKWS {
    NSLog(@"KWSRequestPermission ==> pushPermissionRequestedInKWS");
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushPermissionRequestedInKWS)]) {
        [_delegate pushPermissionRequestedInKWS];
    }
}

- (void) delParentEmailIsMissingInKWS {
    NSLog(@"KWSRequestPermission ==> parentEmailIsMissingInKWS");
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(parentEmailIsMissingInKWS)]) {
        [_delegate parentEmailIsMissingInKWS];
    }
}

- (void) delRequestError {
    NSLog(@"KWSRequestPermission ==> requestError");
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(requestError)]) {
        [_delegate requestError];
    }
}

@end
