/**
 * @Copyright:   SuperAwesome Trading Limited 2017
 * @Author:      Gabriel Coman (gabriel.coman@superawesome.tv)
 */

#import <UIKit/UIKit.h>
#import "NSArray+KWSJson.h"
#import "NSDictionary+KWSJson.h"
#import "NSDictionary+KWSSafeHandling.h"

/**
 * This acts as a type of base object for all models that might be used 
 * later on by the SDK.
 * It already contains an implementation for the basic methods that would 
 * need to be implemented by a "Serializable" object
 */
@interface KWSBaseObject : NSObject
@end

@interface KWSBaseObject (KWSJson) <KWSDeserializationProtocol, KWSSerializationProtocol>
@end
