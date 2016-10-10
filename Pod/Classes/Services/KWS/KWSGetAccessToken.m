//
//  KWSOAuthService.m
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import "KWSGetAccessToken.h"
#import "KWS.h"
#import "SAUtils.h"
#import "KWSAccessToken.h"

@interface KWSGetAccessToken ()
@property (nonatomic, strong) gotAccessToken gotAccessToken;
@end

@implementation KWSGetAccessToken

- (id) init {
    if (self = [super init]) {
        _gotAccessToken = ^(BOOL success, NSString *token) {};
    }
    return self;
}

- (NSString*) getEndpoint {
    return @"oauth/token";
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getHeader {
    return @{
        @"Content-Type" : @"application/x-www-form-urlencoded"
    };
}

- (NSDictionary*) getBody {
    return @{
        @"grant_type": @"client_credentials",
        @"client_id": nullSafe([[KWS sdk] getClientId]),
        @"client_secret": nullSafe([[KWS sdk] getClientSecret])
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    
    if (!success) {
        _gotAccessToken (false, nil);
    } else {
        if (status == 200 && payload != nil) {
            KWSAccessToken *accessToken = [[KWSAccessToken alloc] initWithJsonString:payload];
            _gotAccessToken (true, accessToken.access_token);
        } else {
            _gotAccessToken (false, nil);
        }
    }
}

- (void) execute:(gotAccessToken)gotAccessToken {
    
    // get the access token callback if it's not null
    _gotAccessToken = gotAccessToken ? gotAccessToken : _gotAccessToken;
    
    // create endpoint
    NSString *endpoint = [NSString stringWithFormat:@"%@%@", [[KWS sdk] getKWSApiUrl], [self getEndpoint]];
    // create url
    NSURL *url = [NSURL URLWithString:endpoint];
    
    // create the requrest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    // set headers
    NSDictionary *header = [self getHeader];
    if (header != NULL && header.allKeys.count > 0) {
        for (NSString *key in header.allKeys) {
            [request setValue:[header objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    // set post data
    NSDictionary *body = [self getBody];
    if (body != NULL && body.allKeys.count > 0) {
        NSMutableArray *bodyParams = [@[] mutableCopy];
        for (NSString *key in body.allKeys) {
            [bodyParams addObject:[NSString stringWithFormat:@"%@=%@", key, [body objectForKey:key]]];
        }
        NSString *bodyStr = [bodyParams componentsJoinedByString:@"&"];
        NSData *bodyData = [bodyStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSDictionary *postLength = [NSString stringWithFormat:@"%d", [bodyData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:bodyData];
    }
    
    // configure the session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable httpresponse, NSError * _Nullable error) {
        
        // get actual result
        NSInteger status = ((NSHTTPURLResponse*)httpresponse).statusCode;
        NSString *payload = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // handle two failure cases
        if (error != NULL || data == NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self successWithStatus:status andPayload:nil andSuccess:false];
            });
            return;
        }
        
        // send response on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self successWithStatus:status andPayload:payload andSuccess:true];
        });
    }];
    // start the session
    [task resume];
    
}

@end
