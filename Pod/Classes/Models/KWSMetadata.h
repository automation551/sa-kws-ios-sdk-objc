//
//  Metadata.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import <Foundation/Foundation.h>

@interface KWSMetadata : NSObject
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger appId;
@property (nonatomic, assign) NSInteger clientId;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, assign) NSInteger iat;
@property (nonatomic, assign) NSInteger exp;
@property (nonatomic, strong) NSString *iss;
@end
