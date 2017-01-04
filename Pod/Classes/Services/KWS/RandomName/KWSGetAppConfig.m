//
//  KWSAppConfig.m
//  Pods
//
//  Created by Gabriel Coman on 04/01/2017.
//
//

#import "KWSGetAppConfig.h"

#import "KWSAppConfig.h"
#import "KWS.h"

@interface KWSGetAppConfig ()
@property (nonatomic, strong) gotAppConfig gotAppConfig;
@end

@implementation KWSGetAppConfig

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/config"];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (BOOL) needsLoggedUser {
    return false;
}

- (NSDictionary*) getQuery {
    return @{
        @"oauthClientId": nullSafe([[KWS sdk] getClientId])
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (status == 200 && success && payload) {
        
        KWSAppConfig *config = [[KWSAppConfig alloc] initWithJsonString:payload];
        _gotAppConfig (config);
        
    } else {
        _gotAppConfig (nil);
    }
}

- (void) execute:(gotAppConfig)gotAppConfig {
    _gotAppConfig = gotAppConfig ? gotAppConfig : ^(KWSAppConfig* config){};
    [super execute];
}

@end
