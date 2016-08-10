//
//  KWSUnsubscribeToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "KWSUnregisterToken.h"
#import "SALogger.h"

@interface KWSUnregisterToken ()
@property (nonatomic, strong) unregisteredToken unregisteredToken;
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSUnregisterToken

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/unsubscribe-push-notifications", metadata.appId, metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"token":nullSafe(_token)
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _unregisteredToken(false);
    } else {
        [SALogger log:payload];
        _unregisteredToken(true);
    }
}

- (void) execute:(NSString*)token :(unregisteredToken)unregisteredToken {
    _unregisteredToken = (unregisteredToken ? unregisteredToken : ^(BOOL success){});
    _token = token;
    [super execute:_token];
}

@end
