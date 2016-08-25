//
//  KWSGetAppData.m
//  Pods
//
//  Created by Gabriel Coman on 25/08/2016.
//
//

#import "KWSGetAppData.h"
#import "KWSAppDataResponse.h"

@interface KWSGetAppData ()
@property (nonatomic, strong) gotAppData gotappdata;
@end

@implementation KWSGetAppData

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/app-data", (long)metadata.appId, (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _gotappdata (@[]);
    } else {
        if (status == 200) {
            KWSAppDataResponse *responsse = [[KWSAppDataResponse alloc] initWithJsonString:payload];
            _gotappdata(responsse.results);
        } else {
            _gotappdata(@[]);
        }
    }
}

- (void) execute:(gotAppData)gotappdata {
    _gotappdata = gotappdata ? gotappdata : ^(NSArray *data) {};
    [super execute];
}

@end
