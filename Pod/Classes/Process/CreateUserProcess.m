//
//  CreateUserProcess.m
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

// get header
#import "CreateUserProcess.h"

// import headers to create a user
#import "KWSGetAccessToken.h"
#import "KWSCreateUser.h"

// get temporary models
#import "KWSLoggedUser.h"

// import main SDK
#import "KWS.h"

// import aux
#import "KWSAux.h"

@interface CreateUserProcess ()
@property (nonatomic, strong) userCreated userCreated;
@property (nonatomic, strong) KWSGetAccessToken *getAccessToken;
@property (nonatomic, strong) KWSCreateUser *createUser;
@end

@implementation CreateUserProcess

- (id) init {
    if (self = [super init]) {
        _getAccessToken = [[KWSGetAccessToken alloc] init];
        _createUser = [[KWSCreateUser alloc] init];
        _userCreated = ^(BOOL success, KWSCreateUserError error) {};
    }
    
    return self;
}

- (void) createWithUsername:(NSString*)username
                andPassword:(NSString*)password
             andDateOfBirth:(NSString*)dateOfBirth
                 andCountry:(NSString*)country
             andParentEmail:(NSString*)parentEmail
                           :(userCreated)userCreated {
    
    // 
    _userCreated = userCreated ? userCreated : _userCreated;
    
    // get access token
    [_getAccessToken execute:^(BOOL success, NSString *accessToken) {
        
        if (success && accessToken) {
            
            // create a user w/ the necessary details
            KWSLoggedUser *loggedUser = [[KWSLoggedUser alloc] init];
            loggedUser.username = username;
            loggedUser.password = password;
            loggedUser.parentEmail = parentEmail;
            loggedUser.country = country;
            loggedUser.dateOfBirth = dateOfBirth;
            loggedUser.accessToken = accessToken;
            loggedUser.metadata = [KWSAux processMetadata:accessToken];
            
            // finally create the user on the back-end
            [_createUser executeWithCreatedUser:loggedUser :^(BOOL success, NSInteger status, KWSLoggedUser *tmpUser) {
                
                // if all is OK
                if (success && tmpUser) {
                    
                    // process final user
                    KWSLoggedUser *finalUser = [[KWSLoggedUser alloc] init];
                    finalUser._id = tmpUser._id;
                    finalUser.token = tmpUser.token;
                    finalUser.username = username;
                    finalUser.password = password;
                    finalUser.parentEmail = parentEmail;
                    finalUser.country = country;
                    finalUser.dateOfBirth = dateOfBirth;
                    finalUser.accessToken = accessToken;
                    finalUser.metadata = [KWSAux processMetadata:tmpUser.token];

                    // set final user
                    [[KWS sdk] setLoggedUser:finalUser];
                    
                    // send callback
                    _userCreated (true, kNilOptions);
                } else {
                    if (status == 409) {
                        _userCreated (false, DuplicateUsername);
                    }
                    else if (status == 400) {
                        _userCreated (false, InvalidCredentials);
                    }
                }
            }];
            
        } else {
            _userCreated (false, NetworkError);
        }
    }];
    
}

@end
