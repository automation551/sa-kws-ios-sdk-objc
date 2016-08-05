//
//  KWSSubscribeToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "KWSSubscribeToken.h"

// aux
#import "KWS.h"
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"
#import "SALogger.h"

@interface KWSSubscribeToken ()
@property (nonatomic, assign) registered registered;
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSSubscribeToken

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
    [self delTokenWasSubscribed];
}

- (void) failure {
    [self delTokenSubscribeError];
}

- (void) execute:(id)param :(registered)registered {
    // get correct param
    if ([param isKindOfClass:[NSString class]]) {
        _token = (NSString*)param;
    } else {
        [self delTokenSubscribeError];
        return;
    }
    
    // save
    _registered = registered;
    
    // call super
    [super execute:param];
}

// MARK: Del functions

- (void) delTokenWasSubscribed {
    if (_registered) {
        _registered(true);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasSubscribed)]) {
//        [_delegate tokenWasSubscribed];
//    }
}

- (void) delTokenSubscribeError {
    if (_registered) {
        _registered(false);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenSubscribeError)]) {
//        [_delegate tokenSubscribeError];
//    }
}

@end
