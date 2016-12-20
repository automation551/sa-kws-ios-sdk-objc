//
//  KWSRequest.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import <Foundation/Foundation.h>

// import metadata
#import "KWSMetadata.h"

typedef NS_ENUM(NSInteger, KWS_HTTP_METHOD) {
    GET,
    POST
};

@protocol KWSRequestProtocol <NSObject>

- (NSString*) getEndpoint;
- (KWS_HTTP_METHOD) getMethod;
- (NSDictionary*) getQuery;
- (NSDictionary*) getHeader;
- (NSDictionary*) getBody;
- (BOOL) needsToBeLoggedIn;
- (void) successWithStatus:(int)status andPayload:(NSString*)payload;
- (void) failure;

@end

@interface KWSRequest : NSObject <KWSRequestProtocol> {
    NSString *kwsApiUrl;
    NSString *oauthToken;
    NSString *version;
    KWSMetadata *metadata;
}

// request basic functions
- (void) execute;
- (void) execute:(id)param;

@end
