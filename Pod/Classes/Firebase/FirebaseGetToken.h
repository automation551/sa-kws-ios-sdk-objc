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

@end

// firebase class
@interface FirebaseGetToken : NSObject

// delegate
@property (nonatomic, weak) id<FirebaseGetTokenProtocol> delegate;

// request
- (void) request;

@end
