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

@interface KWSSubscribeToken ()
@property (nonatomic, assign) NSString *token;
@end

@implementation KWSSubscribeToken

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/%ld/users/%ld/subscribe-push-notifications", metadata.appId, metadata.userId];
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
    NSLog(@"%@", payload);
    [self delTokenWasSubscribed];
}

- (void) failure {
    [self delTokenSubscribeError];
}

- (void) execute:(id)param {
    
    // get correct param
    if ([param isKindOfClass:[NSString class]]) {
        _token = (NSString*)param;
    } else {
        [self delTokenSubscribeError];
        return;
    }
    
    // call super
    [super execute:param];
}

// MARK: Del functions

- (void) delTokenWasSubscribed {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasSubscribed)]) {
        [_delegate tokenWasSubscribed];
    }
}

- (void) delTokenSubscribeError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenSubscribeError)]) {
        [_delegate tokenSubscribeError];
    }
}

@end
