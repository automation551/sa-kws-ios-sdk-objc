//
//  KWSCheckRegistered.m
//  Pods
//
//  Created by Gabriel Coman on 14/07/2016.
//
//

// header
#import "KWSCheckRegistered.h"

// aux
#import "KWS.h"
#import "SANetwork.h"
#import "SALogger.h"

// models
#import "KWSMetadata.h"
#import "KWSUser.h"
#import "KWSPermissions.h"

@implementation KWSCheckRegistered

// MARL: Main function

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/has-device-token", metadata.appId, metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    if ([payload isEqualToString:@"true"]) {
        [self delUserIsRegistered];
    } else if ([payload isEqualToString:@"false"]) {
        [self delUserIsNotRegistered];
    } else {
        [self delCheckRegisteredError];
    }
}

- (void) failure {
    [self delCheckRegisteredError];
}

// MARK: Delegates

- (void) delUserIsRegistered {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(userIsRegistered)]) {
        [_delegate userIsRegistered];
    }
}

- (void) delUserIsNotRegistered {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(userIsNotRegistered)]) {
        [_delegate userIsNotRegistered];
    }
}

- (void) delCheckRegisteredError {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(checkRegisteredError)]) {
        [_delegate checkRegisteredError];
    }
}

@end
