//
//  KWSRandomName.m
//  Pods
//
//  Created by Gabriel Coman on 20/12/2016.
//
//

#import "KWSRandomName.h"

@interface KWSRandomName ()
@property (nonatomic, assign) NSInteger appId;
@end

@implementation KWSRandomName

// MARK: Main class function

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v2/apps/%ld/random-display-name", (long)_appId];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (NSDictionary*) getHeader {
    return @{};
}

- (BOOL) needsToBeLoggedIn {
    return false;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    
    if (status == 200 && payload != nil) {
        [self delDidGetRandomName:[payload stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
    } else {
        [self delDidGetRandomName:nil];
    }
}

- (void) failure {
    [self delDidGetRandomName:nil];
}

- (void) execute:(NSInteger)appId :(id)param {
    _appId = appId;
    _delegate = param;
    [super execute];
}

// MARK: Delegate handler functions

- (void) delDidGetRandomName: (NSString*) name {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didGetRandomName:)]) {
        [_delegate didGetRandomName:name];
    }
}

@end
