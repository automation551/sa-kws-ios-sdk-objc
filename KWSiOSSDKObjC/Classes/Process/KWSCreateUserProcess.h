//
//  CreateUserProcess.h
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import <Foundation/Foundation.h>

// create user status
typedef NS_ENUM(NSInteger, KWSChildrenCreateUserStatus) {
    KWSChildren_CreateUser_Success             = 0,
    KWSChildren_CreateUser_InvalidUsername     = 1,
    KWSChildren_CreateUser_InvalidPassword     = 2,
    KWSChildren_CreateUser_InvalidDateOfBirth  = 3,
    KWSChildren_CreateUser_InvalidCountry      = 4,
    KWSChildren_CreateUser_InvalidParentEmail  = 5,
    KWSChildren_CreateUser_DuplicateUsername   = 6,
    KWSChildren_CreateUser_NetworkError        = 7,
    KWSChildren_CreateUser_InvalidOperation    = 8
};

typedef void (^KWSChildrenCreateUserBlock)(KWSChildrenCreateUserStatus status);

@interface KWSCreateUserProcess : NSObject

- (void) createWithUsername:(NSString*)username
                andPassword:(NSString*)password
             andDateOfBirth:(NSString*)dateOfBirth
                 andCountry:(NSString*)country
             andParentEmail:(NSString*)parentEmail
                           :(KWSChildrenCreateUserBlock)response;

@end
