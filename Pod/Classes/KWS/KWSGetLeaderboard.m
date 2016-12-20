//
//  KWSGetLeaderboard.m
//  Pods
//
//  Created by Gabriel Coman on 28/07/2016.
//
//

#import "KWSGetLeaderboard.h"

@implementation KWSGetLeaderboard

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/apps/%ld/leaders", metadata.appId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    NSLog(@"Status %ld and payload %@", (long)status, payload);
}

- (void) failure {
    
}

@end
