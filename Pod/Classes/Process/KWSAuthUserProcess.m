//
//  KWSAuthUserProcess.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2016.
//
//

#import "KWSAuthUserProcess.h"

// get the two systems needed
#import "KWSGetAccessTokenAuth.h"
#import "KWSAuthUser.h"
#import "KWSAccessToken.h"
#import "KWSLoggedUser.h"

// get aux
#import "KWSAux.h"

// import KWS
#import "KWS.h"

@interface KWSAuthUserProcess ()
@property (nonatomic, strong) userAuthenticated userAuthenticated;
@property (nonatomic, strong) KWSGetAccessTokenAuth *getAccessToken;
@property (nonatomic, strong) KWSAuthUser *authUser;
@end

@implementation KWSAuthUserProcess

- (id) init {
    if (self = [super init]) {
        _getAccessToken = [[KWSGetAccessTokenAuth alloc] init];
        _authUser = [[KWSAuthUser alloc] init];
        _userAuthenticated = ^(KWSAuthUserStatus status) {};
    }
    
    return self;
}


- (void) authWithUsername:(NSString*)username
              andPassword:(NSString*)password
                         :(userAuthenticated)userAuthenticated {
    
    // form data
    _userAuthenticated = userAuthenticated ? userAuthenticated : _userAuthenticated;
    BOOL usernameValid = [self validateUsername:username];
    BOOL passwordValid = [self validatePassword:password];
    
    if (!usernameValid) {
        _userAuthenticated (KWSAuthUser_InvalidCredentials);
        return;
    }
    
    if (!passwordValid) {
        _userAuthenticated (KWSAuthUser_InvalidCredentials);
        return;
    }
    
    [_getAccessToken execute:username andPassword:password :^(KWSAccessToken *accessToken) {
        
        if (accessToken) {
            
            [_authUser executeWithToken:accessToken.access_token :^(NSInteger status, KWSLoggedUser *user) {
               
                if (user != nil && [user isValid]) {
                    
                    // save to SDK
                    [[KWS sdk] setLoggedUser:user];
                    
                    // send success
                    _userAuthenticated (KWSAuthUser_Success);
                    
                } else {
                    _userAuthenticated (KWSAuthUser_InvalidCredentials);
                }
                
            }];
            
        } else {
            _userAuthenticated (KWSAuthUser_NetworkError);
        }
        
    }];
}

- (BOOL) validateUsername: (NSString*) username {
    return username && [KWSAux validate:username withRegex:@"^[a-zA-Z0-9]*$"] && [username length] >= 3;
}

- (BOOL) validatePassword: (NSString*) password {
    return password && [password length] >= 8;
}

@end
