//
//  OAuthData.h
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 26/01/2018.
//

#import <Foundation/Foundation.h>

@interface OAuthData: NSObject

@property (nonatomic, strong) NSString* codeChallenge;
@property (nonatomic, strong) NSString* codeVerifier;
@property (nonatomic, strong) NSString* codeChallengeMethod;

-(id) initWithCodeVerifier: (NSString*) codeVerifier
            andCodeChallenge:(NSString*) codeChallenge
      andCodeChallengeMethod:(NSString*) codeChallengeMethod;

@end
