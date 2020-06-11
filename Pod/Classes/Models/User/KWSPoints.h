//
//  KWSPoints.h
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSJsonParser.h"
#import "KWSBaseObject.h"

@interface KWSPoints : KWSBaseObject <KWSSerializationProtocol, KWSDeserializationProtocol>

@property (nonatomic, assign) NSInteger totalReceived;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger totalPointsReceivedInCurrentApp;
@property (nonatomic, assign) NSInteger availableBalance;
@property (nonatomic, assign) NSInteger pending;

@end
