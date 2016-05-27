//
//  NSObject+JSONInterface.h
//  Pods
//
//  Created by Gabriel Coman on 26/05/2016.
//
//

#import <Foundation/Foundation.h>

@protocol SADeserializationProtocol <NSObject>

// json init function
@required
- (id) initWithJsonDictionary:(NSDictionary*)jsonDictionary;
@optional
- (id) initWithJsonString:(NSString*)jsonString;
- (id) initWithJsonData:(NSData*)jsonData;

// validate functions
@required
- (BOOL) isValid;

@end
