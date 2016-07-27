//
//  KWSGetUser.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import "KWSGetUser.h"

// aux
#import "KWS.h"
#import "SANetwork.h"
#import "SALogger.h"

// models
#import "KWSMetadata.h"
#import "KWSUser.h"

@implementation KWSGetUser

- (void) getUser {
    NSString *kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    NSString *oauthToken = [[KWS sdk] getOAuthToken];
    KWSMetadata *metadata = [[KWS sdk] getMetadata];
    NSString *version = [[KWS sdk] getVersion];
    
    if (kwsApiUrl && oauthToken && metadata != NULL) {
        NSInteger userId = metadata.userId;
        NSString *endpoint = [NSString stringWithFormat:@"%@users/%ld", kwsApiUrl, (long)userId];
        
        NSDictionary *header = @{@"Content-Type":@"application/json",
                                 @"Authorization":[NSString stringWithFormat:@"Bearer %@", oauthToken],
                                 @"kws-sdk-version":version};
        
        SANetwork *network = [[SANetwork alloc] init];
        [network sendGET:endpoint withQuery:@{} andHeader:header andSuccess:^(NSInteger code, NSString *json) {
            if ((code == 200 || code == 204) && json != NULL) {
                
                KWSUser *user = [[KWSUser alloc] initWithJsonString:json];
                NSLog(@"%@", [user jsonPreetyStringRepresentation]);
            }
            else {
                
            }
        } andFailure:^{
            
        }];
    }
    else {
        // fail
    }
}

@end
