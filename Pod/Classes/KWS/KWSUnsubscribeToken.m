//
//  KWSUnsubscribeToken.m
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import "KWSUnsubscribeToken.h"

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

@interface KWSUnsubscribeToken ()
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSUnsubscribeToken

// MARK: Main Functions

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/%ld/users/%ld/unsubscribe-push-notifications", metadata.appId, metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"token":_token
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    NSLog(@"%@", payload);
    [self delTokenWasUnsubscribed];
}

- (void) failure {
    [self delTokenUnsubscribeError];
}

- (void) execute:(id)param {
    // check is valid param
    if ([param isKindOfClass:[NSString class]] ){
        _token = (NSString*)param;
    } else {
        [self delTokenUnsubscribeError];
        return;
    }
    
    // call to super
    [super execute:param];
}

// MARK: Delegate handler functions

- (void) delTokenWasUnsubscribed {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasUnsubscribed)]){
        [_delegate tokenWasUnsubscribed];
    }
}

- (void) delTokenUnsubscribeError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenUnsubscribeError)]) {
        [_delegate tokenUnsubscribeError];
    }
}

@end
