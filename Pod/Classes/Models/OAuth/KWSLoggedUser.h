//
//  KWSCreatedUser.h
//  Pods
//
//  Created by Gabriel Coman on 10/10/2016.
//
//

#import <SAJsonParser/SAJsonParser.h>

@class KWSMetadata;

@interface KWSLoggedUser : SABaseObject <SASerializationProtocol, SADeserializationProtocol>
@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *parentEmail;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) KWSMetadata *metadata;
@end
