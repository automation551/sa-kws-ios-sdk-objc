//
//  KWSSetAppData.m
//  Pods
//
//  Created by Gabriel Coman on 25/08/2016.
//
//

#import "KWSSetAppData.h"

@interface KWSSetAppData ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) setAppData setappdata;
@end

@implementation KWSSetAppData

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"apps/%ld/users/%ld/app-data/set", (long)metadata.appId, (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
             @"name": nullSafe(_name),
             @"value": @(_value)
             };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    _setappdata (success && (status == 200 || status == 204));
}

- (void) execute:(NSString *)name withValue:(NSInteger)value :(setAppData)setappdata {
    _name = name;
    _value = value;
    _setappdata = setappdata ? setappdata : ^(BOOL success) {};
    [super execute];
}

@end
