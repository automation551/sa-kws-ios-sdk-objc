//
//  KWS.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWS.h"
#import "KWSMetadata.h"
#import "NSObject+ModelToString.h"
#import "NSObject+StringToModel.h"

@implementation KWS

+ (KWS*) sdk {
    static KWS *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

// <Setup> function

- (void) setup:(NSString *)oauthToken url:(NSString *)kwsApiUrl delegate:(id<KWSProtocol>)delegate {
    self.oauthToken = oauthToken;
    self.kwsApiUrl = kwsApiUrl;
    self.delegate = delegate;
    self.metadata = [self getMetadata:oauthToken];
    NSLog(@"Json Model: %@", [self.metadata jsonStringPreetyRepresentation]);
    
}

// <Public> functions

- (void) checkIfNotificationsAreAllowed {
    
}

- (void) submitParentEmail:(NSString*)email {
    
}

- (void) registerForRemoteNotifications {
    
}



// <Private> function

- (KWSMetadata*) getMetadata:(NSString*)oauthToken {
    NSArray *subtokens = [oauthToken componentsSeparatedByString:@"."];
    NSString *tokenO = nil;
    if (subtokens.count >= 2) tokenO = subtokens[1];
    if (tokenO == nil) return nil;
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[NSString stringWithFormat:@"%@==", tokenO] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodedJson = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return [[KWSMetadata alloc] initModelFromJsonString:decodedJson andOptions:Strict];
}

@end
