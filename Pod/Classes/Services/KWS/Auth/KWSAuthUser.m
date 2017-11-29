//
//  KWSAuthUser.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import "KWSAuthUser.h"
#import "KWSAccessToken.h"
#import "KWSChildren.h"
#import "KWSMetadata.h"
#import "KWSAccessToken.h"

@interface KWSAuthUser ()
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) authenticated authenticated;
@end

@implementation KWSAuthUser

- (id) init {
    if (self = [super init]) {
        _authenticated = ^(NSInteger status, KWSLoggedUser* user) {};
    }
    return self;
}

- (NSString*) getEndpoint {
    return @"oauth/token";
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (BOOL) needsLoggedUser {
    return false;
}

- (NSDictionary*) getBody {
    return @{
        @"grant_type": @"password",
        @"username": nullSafe(_username),
        @"password": nullSafe(_password),
        @"client_id" : nullSafe([[KWSChildren sdk] getClientId]),
        @"client_secret": nullSafe([[KWSChildren sdk] getClientSecret])
    };
}

- (NSDictionary*) getHeader {
    return @{
        @"Content-Type" : @"application/x-www-form-urlencoded"
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _authenticated(status, nil);
    } else {
        if (status == 200 && payload != nil) {
            
            // create a new logged user that will have a proper OAuth token
            KWSAccessToken *accessToken = [[KWSAccessToken alloc] initWithJsonString:payload];
            KWSLoggedUser *user = [[KWSLoggedUser alloc] init];
            user.token = accessToken.access_token;
            user.metadata = [KWSMetadata processMetadata:user.token];
            
            // send good user
            _authenticated (status, user);
            
        } else {
            _authenticated (status, nil);
        }
    }
}

- (void) execute:(NSString*)username andPassword:(NSString*)password :(authenticated) authenticated {
    _username = username;
    _password = password;
    _authenticated = authenticated ? authenticated : _authenticated;
    
    // create endpoint
    NSString *endpoint = [NSString stringWithFormat:@"%@%@", [[KWSChildren sdk] getKWSApiUrl], [self getEndpoint]];
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
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[bodyData length]];
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
