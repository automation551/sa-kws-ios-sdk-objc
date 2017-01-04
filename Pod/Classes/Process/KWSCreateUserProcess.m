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
#import "KWS.h"

// import aux
#import "KWSAux.h"

@interface KWSCreateUserProcess ()
@property (nonatomic, strong) userCreated userCreated;
@property (nonatomic, strong) KWSGetAccessTokenCreate *getAccessToken;
@property (nonatomic, strong) KWSCreateUser *createUser;
@end

@implementation KWSCreateUserProcess

- (id) init {
    if (self = [super init]) {
        _getAccessToken = [[KWSGetAccessTokenCreate alloc] init];
        _createUser = [[KWSCreateUser alloc] init];
        _userCreated = ^(KWSCreateUserStatus error) {};
    }
    
    return self;
}

- (void) createWithUsername:(NSString*)username
                andPassword:(NSString*)password
             andDateOfBirth:(NSString*)dateOfBirth
                 andCountry:(NSString*)country
             andParentEmail:(NSString*)parentEmail
                           :(userCreated)userCreated {
    
    // get a proper callback and make sure it's never nil
    _userCreated = userCreated ? userCreated : _userCreated;
    
    // validate stuff
    BOOL validUsername = [self validateUsername:username];
    BOOL validPassword = [self validatePassword:password];
    BOOL validDate = [self validateDate:dateOfBirth];
    BOOL validEmail = [self validateEmail:parentEmail];
    BOOL validCountry = [self validateCountry:country];
    
    if (!validUsername) {
        _userCreated (KWSCreateUser_InvalidUsername);
        return;
    }
    
    if (!validPassword) {
        _userCreated (KWSCreateUser_InvalidPassword);
        return;
    }
    
    if (!validDate) {
        _userCreated (KWSCreateUser_InvalidDateOfBirth);
        return;
    }
    
    if (!validEmail) {
        _userCreated (KWSCreateUser_InvalidParentEmail);
        return;
    }
    
    if (!validCountry) {
        _userCreated (KWSCreateUser_InvalidCountry);
        return;
    }
    
    // get access token
    [_getAccessToken execute:^(KWSAccessToken *accessToken) {
        
        if (accessToken) {
            
            KWSMetadata *tmpMetadata = [KWSMetadata processMetadata:accessToken.access_token];
            
            [_createUser executeWith:accessToken.access_token
                            andAppId:tmpMetadata.appId
                         andUsername:username
                         andPassword:password
                      andDateOfBirth:dateOfBirth
                          andCountry:country
                      andParentEmail:parentEmail
                          onResponse:^(NSInteger status, KWSLoggedUser *user) {
                              
                              if (user != nil && [user isValid]) {
                                  
                                  // set final user
                                  [[KWS sdk] setLoggedUser:user];
                                  
                                  // send callback
                                  _userCreated (KWSCreateUser_Success);
                                  
                              }
                              else {
                                  if (status == 409) {
                                      _userCreated (KWSCreateUser_DuplicateUsername);
                                  }
                                  else {
                                      _userCreated (KWSCreateUser_InvalidOperation);
                                  }
                              }
                          }];
            
        } else {
            _userCreated (KWSCreateUser_NetworkError);
        }
    }];
    
}


- (BOOL) validateUsername: (NSString*) username {
    return username && [KWSAux validate:username withRegex:@"^[a-zA-Z0-9]*$"] && [username length] >= 3;
}

- (BOOL) validatePassword: (NSString*) password {
    return password && [password length] >= 8;
}

- (BOOL) validateEmail: (NSString *) email {
    return email && [KWSAux validate:email withRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (BOOL) validateDate: (NSString*) dateOfBirth {
    return dateOfBirth && [KWSAux validate:dateOfBirth withRegex:@"[0-9]{4}-[0-9]{2}-[0-9]{2}"];
}

- (BOOL) validateCountry: (NSString*) country {
    return country && [KWSAux validate:country withRegex:@"[A-Z]{2}"];
}

@end
