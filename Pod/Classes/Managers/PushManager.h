//
//  PushManager.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

#import "FirebaseGetToken.h"
#import "KWSSubscribeToken.h"
#import "KWSUnsubscribeToken.h"

// protocol
@protocol PushManagerProtocol <NSObject>

- (void) didRegister:(NSString*)token;
- (void) didUnregister;
- (void) didFailBecauseFirebaseIsNotSetup;
- (void) didFailToGetFirebaseToken;
- (void) networkErrorTryingToSubscribeToken;
- (void) networkErrorTryingToUnsubscribeToken;

@end

// class
@interface PushManager : NSObject <FirebaseGetTokenProtocol, KWSSubscribeTokenProtocol, KWSUnsubscribeTokenProtocol>

// singleton
+ (instancetype) sharedInstance;

// delegate
@property (nonatomic, weak) id<PushManagerProtocol> delegate;

// main public functions
- (void) registerForPushNotifications;
- (void) unregisterForPushNotifications;

@end
