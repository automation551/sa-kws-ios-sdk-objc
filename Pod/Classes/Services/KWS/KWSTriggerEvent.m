//
//  KWSTriggerEvent.m
//  Pods
//
//  Created by Gabriel Coman on 08/08/2016.
//
//

#import "KWSTriggerEvent.h"

@interface KWSTriggerEvent ()
@property (nonatomic, strong) NSString *evtToken;
@property (nonatomic, assign) NSInteger evtPoints;
@property (nonatomic, strong) NSString *evtDescription;
@property (nonatomic, strong) triggered triggered;
@end

@implementation KWSTriggerEvent

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld/trigger-event", (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    NSMutableDictionary *evtDict = [@{} mutableCopy];
    if (_evtToken != NULL) {
        [evtDict setObject:_evtToken forKey:@"token"];
    }
    if (_evtDescription != NULL && _evtDescription.length > 0) {
        [evtDict setObject:_evtDescription forKey:@"description"];
    }
    [evtDict setValue:@(_evtPoints) forKey:@"points"];
    return evtDict;
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _triggered (false);
    } else {
        if (status == 200 || status == 204) {
            _triggered (true);
        } else {
            _triggered (false);
        }
    }
}

- (void) execute:(NSString *)token points:(NSInteger)points description:(NSString *)description :(triggered)triggered {
    // get vars
    _evtToken = token;
    _evtPoints = points;
    _evtDescription = description;
    
    // get callback
    _triggered = (triggered ? triggered : ^(BOOL success){});
    
    // call to super
    [super execute];
}

@end
