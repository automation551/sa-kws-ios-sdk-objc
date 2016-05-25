//
//  KWSNetworking.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSNetworking.h"
#import "KWSLogger.h"

@implementation KWSNetworking

+ (void) sendGET:(NSString*)endpoint token:(NSString*)token callback:(KWSResponse)response {
    NSURL *url = [NSURL URLWithString:endpoint];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = @"GET";
    [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    KWSNetResponse resp = ^(NSData *data, NSURLResponse *urlresponse, NSError *error) {
        
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)urlresponse;
        NSInteger statusCode = httpresponse.statusCode;
        NSString *jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (jsonResponse) {
                [KWSLogger log:[NSString stringWithFormat:@"GET request OK to %@ | %ld", endpoint, statusCode]];
            } else {
                [KWSLogger err:[NSString stringWithFormat:@"GET request NOK to %@", endpoint]];
            }
            
            response(jsonResponse, statusCode);
        });
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:resp];
    [task resume];
}

+ (void) sendPOST:(NSString*)endpoint token:(NSString*)token body:(NSDictionary*)body callback:(KWSResponse)response {
    NSURL *url = [NSURL URLWithString:endpoint];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = @"POST";
    [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
    
    KWSNetResponse resp = ^(NSData *data, NSURLResponse *urlresponse, NSError *error) {
        
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)urlresponse;
        NSInteger statusCode = httpresponse.statusCode;
        NSString *jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (jsonResponse) {
                [KWSLogger log:[NSString stringWithFormat:@"POST request OK to %@ | %ld", endpoint, statusCode]];
            } else {
                [KWSLogger err:[NSString stringWithFormat:@"POST request NOK to %@", endpoint]];
            }
            
            
            response(jsonResponse, statusCode);
        });
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:resp];
    [task resume];
}

@end
