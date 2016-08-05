//
//  KWSSubscribeToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "KWSRegisterToken.h"
#import "SALogger.h"

@interface KWSRegisterToken ()
@property (nonatomic, strong) registeredToken registeredToken;
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSRegisterToken

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/subscribe-push-notifications", (long)metadata.appId, (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"token": _token,
        @"platform": @"ios"
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    [SALogger log:payload];
    _registeredToken(true);
}

- (void) failure {
    _registeredToken(false);
}

- (void) execute:(NSString*)token :(registeredToken)registeredToken {
    _registeredToken = (registeredToken ? registeredToken : ^(BOOL success){});
    _token = token;
    [super execute:_token];
}

@end
