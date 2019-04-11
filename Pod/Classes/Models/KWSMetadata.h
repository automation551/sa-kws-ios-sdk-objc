//
//  Metadata.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>

#if defined(__has_include)
#if __has_include(<SAJsonParser/SAJsonParser.h>)
#import <SAJsonParser/SAJsonParser.h>
#else
#import "SAJsonParser.h"
#endif
#if __has_include(<SAJsonParser/SABaseObject.h>)
#import <SAJsonParser/SABaseObject.h>
#else
#import "SABaseObject.h"
#endif
#endif

/**
 *  Object containing KWS metadata like current user id, app id, etc
 */
@interface KWSMetadata : SABaseObject <SASerializationProtocol, SADeserializationProtocol>

// current userId (used in forming endpoints)
@property (nonatomic, assign) NSInteger userId;

// current appId (used in forming endpoints)
@property (nonatomic, assign) NSInteger appId;

// client Id
@property (nonatomic, assign) NSInteger clientId;

// scope
@property (nonatomic, strong) NSString *scope;

// start date
@property (nonatomic, assign) NSInteger iat;

// expiration date
@property (nonatomic, assign) NSInteger exp;

// ?
@property (nonatomic, strong) NSString *iss;

@end
