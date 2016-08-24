//
//  KWSGetScore.m
//  Pods
//
//  Created by Gabriel Coman on 24/08/2016.
//
//

#import "KWSGetScore.h"

@interface KWSGetScore ()
@property (nonatomic, strong) gotScore gotscore;
@end

@implementation KWSGetScore

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/score", (long)metadata.appId];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _gotscore(nil);
    } else {
        if (status == 200 && payload) {
            KWSScore *score = [[KWSScore alloc] initWithJsonString:payload];
            _gotscore(score);
        } else {
            _gotscore(nil);
        }
    }
}

- (void) execute:(gotScore)gotscore {
    _gotscore = (_gotscore  ? _gotscore : ^(KWSScore *score){});
    [super execute];
}

@end
