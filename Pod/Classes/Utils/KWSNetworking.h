//
//  KWSNetworking.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

typedef void (^KWSResponse)(NSString *json, NSInteger code);
typedef void (^KWSNetResponse)(NSData * data, NSURLResponse * response, NSError * error);

@interface KWSNetworking : NSObject

+ (void) sendGET:(NSString*)endpoint token:(NSString*)token callback:(KWSResponse)response;
+ (void) sendPOST:(NSString*)endpoint token:(NSString*)token body:(NSDictionary*)body callback:(KWSResponse)response;

@end
