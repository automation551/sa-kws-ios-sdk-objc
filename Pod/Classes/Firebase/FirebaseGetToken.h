//
//  FirebaseGetToken.h
//  Pods
//
//  Created by Gabriel Coman on 28/06/2016.
//
//

#import <Foundation/Foundation.h>

// protocol
@protocol FirebaseGetTokenProtocol <NSObject>

- (void) didGetFirebaseToken: (NSString*) token;
- (void) didFailToGetFirebaseToken;
- (void) didFailBecauseFirebaseIsNotSetup;

@end

// firebase class
@interface FirebaseGetToken : NSObject

// delegate
@property (nonatomic, weak) id<FirebaseGetTokenProtocol> delegate;

// setuo
- (void) setup;

// get token
- (NSString*) getFirebaseToken;

@end
