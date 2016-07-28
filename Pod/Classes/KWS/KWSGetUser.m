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
#import "SANetwork.h"
#import "SALogger.h"

// models
#import "KWSMetadata.h"
#import "KWSUser.h"

@implementation KWSGetUser

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld", (long)[metadata userId]];
}

- (KWS_HTTP_METHOD) getMethod {
    return GET;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    
    if ((status == 200 || status == 204) && payload != NULL) {
        KWSUser *user = [[KWSUser alloc] initWithJsonString:payload];
        [SALogger log:[user jsonPreetyStringRepresentation]];
    }
    else {
        
    }
    
}

- (void) failure {
    
}

@end
