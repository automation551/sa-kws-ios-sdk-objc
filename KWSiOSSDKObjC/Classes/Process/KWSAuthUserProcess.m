//
//  KWSAuthUserProcess.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import "KWSAuthUserProcess.h"

// get the two systems needed
#import "KWSAuthUser.h"
#import "KWSAccessToken.h"
#import "KWSLoggedUser.h"
#import "KWSWebAuth.h"

// import KWS
#import "KWSChildren.h"

#import "OAuthHelper.h"
#import "KWSOAuthToken.h"

@interface KWSAuthUserProcess ()
@property (nonatomic, strong) KWSChildrenLoginUserBlock userAuthenticated;
@property (nonatomic, strong) KWSAuthUser *authUser;
@property (nonatomic, strong) KWSWebAuth *webAuth;
@property (nonatomic, strong) KWSOAuthToken *oAuthToken;

@end

@implementation KWSAuthUserProcess

- (id) init {
    if (self = [super init]) {
        _authUser = [[KWSAuthUser alloc] init];
        _webAuth = [[KWSWebAuth alloc] init];
        _userAuthenticated = ^(KWSChildrenLoginUserStatus status) {};
        _oAuthToken = [[KWSOAuthToken alloc] init];
    }
    
    return self;
}


- (void) authWithUsername:(NSString*)username
              andPassword:(NSString*)password
                         :(KWSChildrenLoginUserBlock)userAuthenticated {
    
    // form data
    _userAuthenticated = userAuthenticated ? userAuthenticated : _userAuthenticated;
    BOOL usernameValid = [self validateUsername:username];
    BOOL passwordValid = [self validatePassword:password];
    
    if (!usernameValid) {
        _userAuthenticated (KWSChildren_LoginUser_InvalidCredentials);
        return;
    }
    
    if (!passwordValid) {
        _userAuthenticated (KWSChildren_LoginUser_InvalidCredentials);
        return;
    }
    
    [_authUser execute:username andPassword:password :^(NSInteger status, KWSLoggedUser *user) {
        
        if (user != nil && [user isValid]) {
            
            // save to SDK
            [[KWSChildren sdk] setLoggedUser:user];
            
            // send success
            _userAuthenticated (KWSChildren_LoginUser_Success);
            
        } else {
            _userAuthenticated (KWSChildren_LoginUser_InvalidCredentials);
        }
    }];
}

- (void) authWithSingleSignOnUrl:(NSString *)url
                      fromParent:(UIViewController *)parent
                                :(KWSChildrenLoginUserBlock)userAuthenticated {
    
    //oauth start
    
    OAuthData *oAuthData = [[[OAuthHelper alloc]init]execute];

    NSString *codeVerifier = [oAuthData codeVerifier];
    NSString *codeChallenge = [oAuthData codeChallenge];
    NSString *codeChallengeMethod = [oAuthData codeChallengeMethod];
                            
    
    // execute the web auth request
    [_webAuth execute:url withParentAuthCode:parent andCodeChallenge: codeChallenge andCodeChallengeMethod: codeChallengeMethod
                     :^(NSString *authCode, BOOL cancelled) {
                         
                         if(authCode != NULL && ![authCode isEqual: @""]){
                             
                             //call new API endpoint with auth code
                             [self authUser:authCode url:url fromParent:parent withCodeVerifier:codeVerifier :userAuthenticated];
                             
                         }  else if (cancelled) {
                             NSLog(@"Cancelled auth process");
                             _userAuthenticated (KWSChildren_LoginUser_Cancelled);
                         }else{
                             NSLog(@"Some other network error happened");
                             _userAuthenticated (KWSChildren_LoginUser_NetworkError);
                             
                         }
                     }];
     
}

- (void) authUser:(NSString *)authCode
              url:(NSString *)url
       fromParent:(UIViewController *)parent
 withCodeVerifier:(NSString *)codeVerifier
                 :(KWSChildrenLoginUserBlock)userAuthenticated {
    
    // form data
    _userAuthenticated = userAuthenticated ? userAuthenticated : _userAuthenticated;

    [_oAuthToken execute:authCode withCodeVerifier:codeVerifier :^(NSInteger status, KWSLoggedUser *user){
        
        //todo response handling
        if (user != nil && [user isValid]) {
            
            // save to SDK
            [[KWSChildren sdk] setLoggedUser:user];
            
            // send success
            _userAuthenticated (KWSChildren_LoginUser_Success);
            
        } else {
            _userAuthenticated (KWSChildren_LoginUser_InvalidCredentials);
        }
        
        
    }];
        
    
}


- (void) openUrl:(NSURL *)url
     withOptions:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [_webAuth openUrl:url withOptions:options];
}

- (BOOL) validateUsername: (NSString*) username {
    return username &&
    [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]*$"] evaluateWithObject:username] &&
    [username length] >= 3;
}

- (BOOL) validatePassword: (NSString*) password {
    return password && [password length] >= 8;
}

@end
