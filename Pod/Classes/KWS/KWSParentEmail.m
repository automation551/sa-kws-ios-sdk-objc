//
//  KWSParentEmail.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSParentEmail.h"

// aux
#import "KWS.h"
#import "KWSNetworking.h"
#import "NSObject+StringToModel.h"
#import "NSObject+ModelToString.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSInvalid.h"

@implementation KWSParentEmail

- (void) submit:(NSString *)email {
    
    if ([KWS sdk].kwsApiUrl != NULL && [KWS sdk].oauthToken != NULL && [KWS sdk].metadata != NULL) {
        
        NSInteger userId = [KWS sdk].metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld/request-permissions", [KWS sdk].kwsApiUrl, (long)userId];
        NSDictionary *body = @{@"permissions":@[@"sendPushNotification"], @"parentEmail": email};
        
        [KWSNetworking sendPOST:endpoint token:[KWS sdk].oauthToken body:body callback:^(NSString *json, NSInteger code) {
            
            if (code == 200 || code == 204){
                [self delEmailSubmittedInKWS];
            } else {
                [self delEmailError];
            }
            
        }];
    }
    else {
        [self delEmailError];
    }
    
}

- (void) delEmailSubmittedInKWS {
    NSLog(@"KWSParentEmail ==> emailSubmittedInKWS");
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(emailSubmittedInKWS)]) {
        [_delegate emailSubmittedInKWS];
    }
}

- (void) delEmailError {
    NSLog(@"KWSParentEmail ==> emailError");
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(emailError)]) {
        [_delegate emailError];
    }
}

@end
