//
//  KWSModel.h
//  KWSiOSSDKObjC
//
//  Created by Gabriel Coman on 07/07/2016.
//  Copyright © 2016 Gabriel Coman. All rights reserved.
//

#import <SAJsonParser/SAJsonParser.h>

@interface KWSModel : SABaseObject
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *error;
@end
