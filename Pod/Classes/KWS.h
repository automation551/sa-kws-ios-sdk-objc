//
//  KWS.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

@class KWSMetadata;

// Protocol

@protocol KWSProtocol <NSObject>

- (void) isAllowedToRegisterForRemoteNotifications;
- (void) isAlreadyRegisteredForRemoteNotifications;
- (void) didRegisterForRemoteNotifications;
- (void) didFailBecauseKWSDoesNotAllowRemoteNotificaitons;
- (void) didFailBecauseKWSCouldNotFindParentEmail;
- (void) didFailBecauseRemoteNotificationsAreDisabled;
- (void) didFailBecauseOfError;

@end

// Class

@interface KWS : NSObject

@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *kwsApiUrl;
@property (nonatomic, strong) KWSMetadata *metadata;
@property (nonatomic, weak) id <KWSProtocol> delegate;

// singleton func
+ (KWS*) sdk;

// setup func
- (void) setup:(NSString*)oauthToken url:(NSString*)kwsApiUrl delegate:(id<KWSProtocol>)delegate;

// public funcs
- (void) checkIfNotificationsAreAllowed;
- (void) submitParentEmail:(NSString*)email;
- (void) registerForRemoteNotifications;

@end
