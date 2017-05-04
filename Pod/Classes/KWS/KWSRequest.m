//
//  KWSRequest.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

// import header
#import "KWSRequest.h"

// import other important headers
#import "KWS.h"
#import "SANetwork.h"

@interface KWSRequest ()
@property (nonatomic, strong) SANetwork *network;
@end

@implementation KWSRequest

// MARK: Init functions

- (id) init {
    if (self = [super init]) {
        _network = [[SANetwork alloc] init];
    }
    return self;
}

// MARK: KWSRequestProtocol method

- (NSString*) getEndpoint {
    return NULL;
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (NSDictionary*) getQuery {
    return @{};
}

- (NSDictionary*) getHeader {
    return @{
        @"Content-Type": @"application/json",
        @"Authorization": [NSString stringWithFormat:@"Bearer %@", oauthToken],
        @"kws-sdk-version": version
    };
}

- (NSDictionary*) getBody {
    return @{};
}

- (BOOL) needsToBeLoggedIn {
    return true;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    // do nothing
}

- (void) failure {
    // do nothing
}

// MARK: Base class methods

- (void) execute {
    
    kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    oauthToken = [[KWS sdk] getOAuthToken];
    metadata = [[KWS sdk] getMetadata];
    version = [[KWS sdk] getVersion];
    
    // check data
    if ((!kwsApiUrl || !oauthToken || !metadata) && [self needsToBeLoggedIn]) {
        [self failure];
        return;
    }
    
    if ([self getMethod] == POST) {
        [_network sendPOST:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                 withQuery:[self getQuery]
                 andHeader:[self getHeader]
                   andBody:[self getBody] withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                       if (success && payload != nil) {
                           [self successWithStatus:(int)status andPayload:payload];
                       }
                       else {
                           [self failure];
                       }
                   }];
    } else {
        [_network sendGET:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                 withQuery:[self getQuery]
                 andHeader:[self getHeader]
              withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                       if (success && payload != nil) {
                           [self successWithStatus:(int)status andPayload:payload];
                       }
                       else {
                           [self failure];
                       }
                   }];
    }
}

- (void) execute:(id)param {
    [self execute];
}

@end
