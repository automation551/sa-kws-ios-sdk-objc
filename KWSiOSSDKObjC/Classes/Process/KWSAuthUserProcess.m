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

// import KWS
#import "KWSChildren.h"

@interface KWSAuthUserProcess ()
@property (nonatomic, strong) KWSChildrenLoginUserBlock userAuthenticated;
@property (nonatomic, strong) KWSAuthUser *authUser;
@end

@implementation KWSAuthUserProcess

- (id) init {
    if (self = [super init]) {
        _authUser = [[KWSAuthUser alloc] init];
        _userAuthenticated = ^(KWSChildrenLoginUserStatus status) {};
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

- (BOOL) validateUsername: (NSString*) username {
    return username &&
            [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]*$"] evaluateWithObject:username] &&
            [username length] >= 3;
}

- (BOOL) validatePassword: (NSString*) password {
    return password && [password length] >= 8;
}

@end
