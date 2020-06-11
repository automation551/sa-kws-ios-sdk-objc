//
//  KWSGetUser.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import "KWSGetUser.h"

// aux
#import "KWS.h"

#if defined(__has_include)
#if __has_include(<SANetwork/SANetwork.h>)
#import <SANetwork/SANetwork.h>
#else
#import "KWSNetwork.h"
#endif
#endif

// models
#import "KWSMetadata.h"
#import "KWSUser.h"

@implementation KWSGetUser

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/users/%ld", (long)[metadata userId]];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    
    if ((status == 200 || status == 204) && payload != NULL) {
        KWSUser *user = [[KWSUser alloc] initWithJsonString:payload];
        NSLog(@"%@", [user jsonPreetyStringRepresentation]);
    }
    else {
        
    }
    
}

- (void) failure {
    
}

@end
