//
//  KWSRequest.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

// import header
#import "KWSService.h"

// import other important headers
#import "KWS.h"
#import "SANetwork.h"

@interface KWSService ()
@property (nonatomic, strong) SANetwork *network;
@end

@implementation KWSService

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

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success{
    // do nothing
}

// MARK: Base class methods

- (void) execute {
    
    kwsApiUrl = [[KWS sdk] getKWSApiUrl];
    oauthToken = [[KWS sdk] getOAuthToken];
    metadata = [[KWS sdk] getMetadata];
    version = [[KWS sdk] getVersion];
    
    // safe block self
    __block id blockSelf = self;
    
    // check data
    if (!kwsApiUrl || !oauthToken || !metadata) {
        [self successWithStatus:0 andPayload:NULL andSuccess:false];
        return;
    }
    
    switch ([self getMethod]) {
        case GET: {
            [_network sendGET:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                    withQuery:[self getQuery]
                    andHeader:[self getHeader]
                 withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                     [blockSelf successWithStatus:(int)status andPayload:payload andSuccess:success];
                 }];
            break;
        }
        case POST: {
            [_network sendPOST:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                     withQuery:[self getQuery]
                     andHeader:[self getHeader]
                       andBody:[self getBody]
                  withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                      [blockSelf successWithStatus:(int)status andPayload:payload andSuccess:success];
                  }];
            break;
        }
        case PUT: {
            [_network sendPUT:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                    withQuery:[self getQuery]
                    andHeader:[self getHeader]
                      andBody:[self getBody]
                 withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                     [blockSelf successWithStatus:status andPayload:payload andSuccess:success];
                 }];
            break;
        }
    }
}

- (void) execute:(id)param {
    [self execute];
}

@end
