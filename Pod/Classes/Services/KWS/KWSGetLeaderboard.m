//
//  KWSGetLeaderboard.m
//  Pods
//
//  Created by Gabriel Coman on 28/07/2016.
//
//

#import "KWSGetLeaderboard.h"

@interface KWSGetLeaderboard ()
@property (nonatomic, assign) gotLeaderboard gotleaderboard;
@end

@implementation KWSGetLeaderboard

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/leaders", (long)metadata.appId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    
    if ((status == 200 || status == 204) && payload) {
        KWSLeaderboard *leaderboard = [[KWSLeaderboard alloc] initWithJsonString:payload];
        [self gotLeaderboardOK:leaderboard.results];
    } else {
        [self gotLeaderboardNOK];
    }
}

- (void) failure {
    [self gotLeaderboardNOK];
}

- (void) execute:(gotLeaderboard)gotleaderboard {
    _gotleaderboard = gotleaderboard;
    [super execute];
}

- (void) gotLeaderboardOK: (NSArray<KWSLeader*> *)leaders {
    if (_gotleaderboard) {
        _gotleaderboard(leaders);
    }
}

- (void) gotLeaderboardNOK {
    if (_gotleaderboard) {
        _gotleaderboard([[NSArray alloc] init]);
    }
}

@end
