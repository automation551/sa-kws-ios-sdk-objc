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
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"
#import "SALogger.h"

@interface KWSUnsubscribeToken ()
@property (nonatomic, assign) registered registered;
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSUnsubscribeToken

// MARK: Main Functions

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/unsubscribe-push-notifications", metadata.appId, metadata.userId];
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
    [SALogger log:payload];
    [self delTokenWasUnsubscribed];
}

- (void) failure {
    [self delTokenUnsubscribeError];
}

- (void) execute:(id)param :(unregistered)registered {
    // check is valid param
    if ([param isKindOfClass:[NSString class]] ){
        _token = (NSString*)param;
    } else {
        [self delTokenUnsubscribeError];
        return;
    }
    
    // save
    _registered = registered;
    
    // call to super
    [super execute:param];
}


// MARK: Delegate handler functions

- (void) delTokenWasUnsubscribed {
    if (_registered) {
        _registered(true);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenWasUnsubscribed)]){
//        [_delegate tokenWasUnsubscribed];
//    }
}

- (void) delTokenUnsubscribeError {
    if (_registered) {
        _registered(false);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(tokenUnsubscribeError)]) {
//        [_delegate tokenUnsubscribeError];
//    }
}

@end
