//
//  KWSApplicationProfile.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@interface KWSApplicationProfile : KWSBaseObject <KWSSerializationProtocol, KWSDeserializationProtocol>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSInteger avatarId;
@property (nonatomic, assign) NSInteger customField1;
@property (nonatomic, assign) NSInteger customField2;
@property (nonatomic, assign) NSInteger customField3;
@property (nonatomic, assign) NSInteger customField4;
@property (nonatomic, assign) NSInteger customField5;

@end
