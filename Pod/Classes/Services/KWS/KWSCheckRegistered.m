//
//  KWSCheckRegistered.m
//  Pods
//
//  Created by Gabriel Coman on 14/07/2016.
//
//

// header
#import "KWSCheckRegistered.h"

@interface KWSCheckRegistered ()
@property (nonatomic, strong) checkRegistered checkRegistered;
@end

@implementation KWSCheckRegistered

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/has-device-token", metadata.appId, metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _checkRegistered(false, false);
    } else {
        if ([payload isEqualToString:@"true"]) {
            _checkRegistered(true, true);
        } else if ([payload isEqualToString:@"false"]) {
            _checkRegistered(true, false);
        } else {
            _checkRegistered(false, false);
        }
    }
}

- (void) execute:(checkRegistered)checkRegistered {
    _checkRegistered = (checkRegistered ? checkRegistered : ^(BOOL success, BOOL registered){});
    [super execute];
}

@end
