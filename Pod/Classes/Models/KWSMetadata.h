//
//  Metadata.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

/**
 *  Object containing KWS metadata like current user id, app id, etc
 */
@interface KWSMetadata : KWSBaseObject <KWSSerializationProtocol, KWSDeserializationProtocol>

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
