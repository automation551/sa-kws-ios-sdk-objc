//
//  OAuthData.m
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 26/01/2018.
//

#import <Foundation/Foundation.h>
#import "OAuthData.h"


@implementation OAuthData

- (id) initWithCodeVerifier:(NSString *)codeVerifier
             andCodeChallenge:(NSString *)codeChallenge
       andCodeChallengeMethod:(NSString *)codeChallengeMethod{
    
    self = [super init];
    
    _codeVerifier = codeVerifier;
    _codeChallenge = codeChallenge;
    _codeChallengeMethod = codeChallengeMethod;
    
    return self;
    
}


@end
