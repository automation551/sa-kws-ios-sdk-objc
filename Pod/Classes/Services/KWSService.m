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
@property (nonatomic, strong) SARequest *request;
@end

@implementation KWSService

// MARK: Init functions

- (id) init {
    if (self = [super init]) {
        _request = [[SARequest alloc] init];
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

- (BOOL) needsLoggedUser {
    return true;
}

- (NSDictionary*) getQuery {
    return @{};
}

- (NSDictionary*) getHeader {
    return @{
        @"Content-Type": @"application/json",
        @"Authorization": [NSString stringWithFormat:@"Bearer %@", loggedUser.token],
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
    loggedUser = [[KWS sdk] getLoggedUser];
    version = [[KWS sdk] getVersion];
    
    // case when the Network request actually needs the SDK to have a logged user,
    // but there is no logged user whatsoever
    if ([self needsLoggedUser] && loggedUser == nil) {
        [self successWithStatus:0 andPayload:nil andSuccess:false];
    }
    // case where either the user is logged or we don't need a logged user
    else {
        // safe block self
        __block id blockSelf = self;
        
        switch ([self getMethod]) {
            case GET: {
                [_request sendGET:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                        withQuery:[self getQuery]
                        andHeader:[self getHeader]
                     withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                         [blockSelf successWithStatus:(int)status andPayload:payload andSuccess:success];
                     }];
                break;
            }
            case POST: {
                [_request sendPOST:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
                         withQuery:[self getQuery]
                         andHeader:[self getHeader]
                           andBody:[self getBody]
                      withResponse:^(NSInteger status, NSString *payload, BOOL success) {
                          [blockSelf successWithStatus:(int)status andPayload:payload andSuccess:success];
                      }];
                break;
            }
            case PUT: {
                [_request sendPUT:[NSString stringWithFormat:@"%@%@", kwsApiUrl, [self getEndpoint]]
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
}

- (void) execute:(id)param {
    [self execute];
}

@end
