//
//  CreateUserProcess.h
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KWSCreateUserError) {
    DuplicateUsername = 0,
    InvalidCredentials = 1,
    NetworkError = 2
};

typedef void (^userCreated)(BOOL success, KWSCreateUserError error);

@interface CreateUserProcess : NSObject

- (void) createWithUsername:(NSString*)username
                andPassword:(NSString*)password
             andDateOfBirth:(NSString*)dateOfBirth
                 andCountry:(NSString*)country
             andParentEmail:(NSString*)parentEmail
                           :(userCreated)userCreated;

@end
