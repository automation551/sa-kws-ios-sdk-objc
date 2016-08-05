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

@interface KWSGetUser ()
@property (nonatomic, assign) gotUser gotuser;
@end

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
        [self gotUserOK:user];
    }
    else {
        [self gotUserNOK];
    }
    
}

- (void) failure {
    [self gotUserNOK];
}

- (void) execute:(gotUser)gotuser {
    _gotuser = gotuser;
    [super execute];
}

- (void) gotUserOK:(KWSUser*)user {
    if (_gotuser) {
        _gotuser(user);
    }
}

- (void) gotUserNOK {
    if (_gotuser) {
        _gotuser(NULL);
    }
}

@end
