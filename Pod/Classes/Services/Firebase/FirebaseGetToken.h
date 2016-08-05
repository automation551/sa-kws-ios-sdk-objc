//
//  FirebaseGetToken.h
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSRequest.h"

// protocol
@protocol FirebaseGetTokenProtocol <NSObject>

- (void) didGetFirebaseToken: (NSString*) token;
- (void) didFailToGetFirebaseToken;
- (void) didFailBecauseFirebaseIsNotSetup;

@end

// callback
typedef void (^gotToken)(BOOL sucess, NSString *token);

// firebase class
@interface FirebaseGetToken : KWSRequest

// delegate
@property (nonatomic, weak) id<FirebaseGetTokenProtocol> delegate;

// function
- (void) execute:(gotToken)gottoken;

// setuo
- (void) setup;

// get token
- (NSString*) getSavedToken;

@end
