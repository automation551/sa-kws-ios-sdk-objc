//
//  KWSNetworking.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSNetworking.h"

@implementation KWSNetworking

+ (void) sendGET:(NSString*)endpoint token:(NSString*)token callback:(response)response {
    NSURL *url = [NSURL URLWithString:endpoint];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = @"GET";
    [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    netresponse resp = ^(NSData *data, NSURLResponse *urlresponse, NSError *error) {
        
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)urlresponse;
        NSInteger statusCode = httpresponse.statusCode;
        NSString *jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            response(jsonResponse, statusCode);
        });
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:resp];
    [task resume];
}

+ (void) sendPOST:(NSString*)endpoint token:(NSString*)token body:(NSDictionary*)body callback:(response)response {
    NSURL *url = [NSURL URLWithString:endpoint];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = @"POST";
    [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
    
    netresponse resp = ^(NSData *data, NSURLResponse *urlresponse, NSError *error) {
        
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)urlresponse;
        NSInteger statusCode = httpresponse.statusCode;
        NSString *jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            response(jsonResponse, statusCode);
        });
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:resp];
    [task resume];
}

@end
