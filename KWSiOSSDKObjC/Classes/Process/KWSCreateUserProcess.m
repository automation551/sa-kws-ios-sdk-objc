//
//  CreateUserProcess.m
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

// get header
#import "KWSCreateUserProcess.h"

// import headers to create a user
#import "KWSGetAccessTokenCreate.h"
#import "KWSCreateUser.h"

// get temporary models
#import "KWSAccessToken.h"
#import "KWSLoggedUser.h"

// import main SDK
#import "KWSChildren.h"
#import "SAUtils.h"

@interface KWSCreateUserProcess ()
@property (nonatomic, strong) KWSChildrenCreateUserBlock response;
@property (nonatomic, strong) KWSGetAccessTokenCreate *getAccessToken;
@property (nonatomic, strong) KWSCreateUser *createUser;
@end

@implementation KWSCreateUserProcess

- (id) init {
    if (self = [super init]) {
        _getAccessToken = [[KWSGetAccessTokenCreate alloc] init];
        _createUser = [[KWSCreateUser alloc] init];
        _response = ^(KWSChildrenCreateUserStatus status) {};
    }
    
    return self;
}

- (void) createWithUsername:(NSString*)username
                andPassword:(NSString*)password
             andDateOfBirth:(NSString*)dateOfBirth
                 andCountry:(NSString*)country
             andParentEmail:(NSString*)parentEmail
                           :(KWSChildrenCreateUserBlock)response {
    
    // get a proper callback and make sure it's never nil
    _response = response ? response : _response;
    
    // validate stuff
    BOOL validUsername = [self validateUsername:username];
    BOOL validPassword = [self validatePassword:password];
    BOOL validDate = [self validateDate:dateOfBirth];
    BOOL validEmail = [self validateEmail:parentEmail];
    BOOL validCountry = [self validateCountry:country];
    
    if (!validUsername) {
        _response (KWSChildren_CreateUser_InvalidUsername);
        return;
    }
    
    if (!validPassword) {
        _response (KWSChildren_CreateUser_InvalidPassword);
        return;
    }
    
    if (!validDate) {
        _response (KWSChildren_CreateUser_InvalidDateOfBirth);
        return;
    }
    
    if (!validEmail) {
        _response (KWSChildren_CreateUser_InvalidParentEmail);
        return;
    }
    
    if (!validCountry) {
        _response (KWSChildren_CreateUser_InvalidCountry);
        return;
    }
    
    // get access token
    [_getAccessToken execute:^(KWSAccessToken *accessToken) {
        
        if (accessToken) {
            
            // get app id info mainly from the previous temporary access token
            KWSMetadata *metadata = [KWSMetadata processMetadata:accessToken.access_token];
            
            // handle error
            if (metadata == nil) {
                _response (KWSChildren_CreateUser_NetworkError);
                return ;
            }
            
            // continue w/ success
            [_createUser executeWith:accessToken.access_token
                            andAppId:metadata.appId
                         andUsername:username
                         andPassword:password
                      andDateOfBirth:dateOfBirth
                          andCountry:country
                      andParentEmail:parentEmail
                          onResponse:^(NSInteger status, KWSLoggedUser *user) {
                              
                              if (user != nil && [user isValid]) {
                                  
                                  // set final user
                                  [[KWSChildren sdk] setLoggedUser:user];
                                  
                                  // send callback
                                  _response (KWSChildren_CreateUser_Success);
                                  
                              }
                              else {
                                  if (status == 409) {
                                      _response (KWSChildren_CreateUser_DuplicateUsername);
                                  }
                                  else {
                                      _response (KWSChildren_CreateUser_InvalidOperation);
                                  }
                              }
                          }];
            
        } else {
            _response (KWSChildren_CreateUser_NetworkError);
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

- (BOOL) validateEmail: (NSString *) email {
    return email && [SAUtils isEmailValid:email];
}

- (BOOL) validateDate: (NSString*) dateOfBirth {
    return
        dateOfBirth &&
        [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]{4}-[0-9]{2}-[0-9]{2}"] evaluateWithObject:dateOfBirth];
}

- (BOOL) validateCountry: (NSString*) country {
    return
        country &&
        [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z]{2}"] evaluateWithObject:country];
}

@end
