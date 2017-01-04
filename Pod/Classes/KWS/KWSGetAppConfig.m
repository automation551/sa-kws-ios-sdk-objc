//
//  KWSGetAppConfig.m
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import "KWSGetAppConfig.h"
#import "KWSAppConfig.h"
#import "KWS.h"

@implementation KWSGetAppConfig

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/config"];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (BOOL) needsToBeLoggedIn {
    return false;
}

- (NSDictionary*) getQuery {
    return @{
        @"oauthClientId": nullSafe([[KWS sdk] getClientId])
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    if (status == 200 && payload) {
        
        KWSAppConfig *config = [[KWSAppConfig alloc] initWithJsonString:payload];
        [self delDidGetAppConfig:config];
        
    } else {
        [self delDidGetAppConfig:nil];
    }
}
    
- (void) delDidGetAppConfig: (KWSAppConfig*) config {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didGetAppConfig:)]) {
        [_delegate didGetAppConfig:config];
    }
}

@end
