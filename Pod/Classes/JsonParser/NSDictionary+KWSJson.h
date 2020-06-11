/**
 * @Copyright:   SuperAwesome Trading Limited 2017
 * @Author:      Gabriel Coman (gabriel.coman@superawesome.tv)
 */

#import <UIKit/UIKit.h>
#import "KWSJsonParser.h"

/**
 *  Extension to NSDictionary to add serializaiton and deserializaiton functions
 */
@interface NSDictionary (KWSJson) <KWSSerializationProtocol, KWSDeserializationProtocol>
@end
