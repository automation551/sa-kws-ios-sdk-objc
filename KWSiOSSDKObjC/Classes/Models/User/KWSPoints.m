//
//  KWSPoints.m
//  Pods
//
//  Created by Gabriel Coman on 27/07/2016.
//
//

#import "KWSPoints.h"

@implementation KWSPoints
    
    - (id) initWithTotalReceived: (NSNumber*) totalReceived andTotal: (NSNumber*) total andTotalPointsReceivedInCurrentApp: (NSNumber*) totalPointsReceivedInCurrentApp andAvailableBalance: (NSNumber*) availableBalance andPending: (NSNumber*) pending{
        
        self = [super init];
         if(self != nil){
             _totalReceived = [totalReceived integerValue];
             _total = [total integerValue];
             _totalPointsReceivedInCurrentApp = [totalPointsReceivedInCurrentApp integerValue];
             _availableBalance = [availableBalance integerValue];
             _pending = [pending integerValue];
         }
        return self;
        
        
    }
    
- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]){
        _totalReceived = [[jsonDictionary safeObjectForKey:@"totalReceived"] integerValue];
        _total = [[jsonDictionary safeObjectForKey:@"total"] integerValue];
        _totalPointsReceivedInCurrentApp = [[jsonDictionary safeObjectForKey:@"totalPointsReceivedInCurrentApp"] integerValue];
        _availableBalance = [[jsonDictionary safeObjectForKey:@"availableBalance"] integerValue];
        _pending = [[jsonDictionary safeObjectForKey:@"pending"] integerValue];
    }
    return self;
}
    
- (BOOL) isValid {
    return true;
}
    
- (NSDictionary*) dictionaryRepresentation {
    return @{
             @"totalReceived": @(_totalReceived),
             @"total": @(_total),
             @"totalPointsReceivedInCurrentApp": @(_totalPointsReceivedInCurrentApp),
             @"availableBalance": @(_availableBalance),
             @"pending": @(_pending)
             };
}
    
    @end
