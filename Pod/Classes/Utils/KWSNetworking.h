//
//  KWSNetworking.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

typedef void (^response)(NSString *json, NSInteger code);
typedef void (^netresponse)(NSData * data, NSURLResponse * response, NSError * error);

@interface KWSNetworking : NSObject

+ (void) sendGET:(NSString*)endpoint token:(NSString*)token callback:(response)response;
+ (void) sendPOST:(NSString*)endpoint token:(NSString*)token body:(NSDictionary*)body callback:(response)response;

@end
