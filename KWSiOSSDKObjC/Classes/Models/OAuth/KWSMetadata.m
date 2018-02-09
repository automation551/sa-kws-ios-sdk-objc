//
//  Metadata.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSMetadata.h"

#define KWS_ID_DEF_VALUE -1

@implementation KWSMetadata

- (id) initWithUserId:(NSNumber *)userId
             andAppId: (NSNumber*) appId
          andClientId: (NSString*) clientId
             andScope: (NSString*) scope
               andIat: (NSNumber*) iat
               andExp:(NSNumber*) exp
               andIss:(NSString*) iss {
    
    self = [self init];
    
    if(self != nil){
        _userId = [userId integerValue];
        _appId = [appId integerValue];
        _clientId = clientId;
        _scope = scope;
        _iat = [iat integerValue];
        _exp = [exp integerValue];
        _iss = iss;
    }
    
    return self;
    
}

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]) {
        
        _userId = [jsonDictionary safeIntForKey:@"userId" orDefault:KWS_ID_DEF_VALUE];
        _appId = [jsonDictionary safeIntForKey:@"appId" orDefault:KWS_ID_DEF_VALUE];
        _clientId = [jsonDictionary safeStringForKey:@"clientId"];
        _scope = [jsonDictionary safeStringForKey:@"scope"];
        _iat = [jsonDictionary safeIntForKey:@"iat" orDefault:KWS_ID_DEF_VALUE];
        _exp = [jsonDictionary safeIntForKey:@"exp" orDefault:KWS_ID_DEF_VALUE];
        _iss = [jsonDictionary safeStringForKey:@"iss"];
        
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _userId = [aDecoder decodeIntegerForKey:@"userId"];
        _appId = [aDecoder decodeIntegerForKey:@"appId"];
        _clientId = [aDecoder decodeObjectForKey:@"clientId"];
        _scope = [aDecoder decodeObjectForKey:@"scope"];
        _iat = [aDecoder decodeIntegerForKey:@"iat"];
        _exp = [aDecoder decodeIntegerForKey:@"exp"];
        _iss = [aDecoder decodeObjectForKey:@"iss"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_userId forKey:@"userId"];
    [aCoder encodeInteger:_appId forKey:@"appId"];
    [aCoder encodeObject:_clientId forKey:@"clientId"];
    [aCoder encodeObject:_scope forKey:@"scope"];
    [aCoder encodeInteger:_exp forKey:@"exp"];
    [aCoder encodeInteger:_iat forKey:@"iat"];
    [aCoder encodeObject:_iss forKey:@"iss"];
}

- (BOOL) isValid {
    if (_appId == KWS_ID_DEF_VALUE || _userId == KWS_ID_DEF_VALUE || _iat == KWS_ID_DEF_VALUE || _exp == KWS_ID_DEF_VALUE) {
        return false;
    } else {
        NSInteger now = [[NSDate date] timeIntervalSince1970];
        NSInteger diff = now - _exp;
        return diff < 0;
    }
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
        @"userId": @(_userId),
        @"appId": @(_appId),
        @"clientId": nullSafe(_clientId),
        @"scope": nullSafe(_scope),
        @"iat": @(_iat),
        @"exp": @(_exp),
        @"iss": nullSafe(_iss)
    };
}

+ (KWSMetadata*) processMetadata:(NSString*)oauthToken {
    if (oauthToken == nil) return nil;
    NSArray *subtokens = [oauthToken componentsSeparatedByString:@"."];
    NSString *token = nil;
    if (subtokens.count >= 2) token = subtokens[1];
    if (token == nil) return nil;
    
    NSString *token0 = token;
    NSString *token1 = [token0 stringByAppendingString:@"="];
    NSString *token2 = [token1 stringByAppendingString:@"="];
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:token0 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (decodedData == nil) {
        decodedData = [[NSData alloc] initWithBase64EncodedString:token1 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if (decodedData == nil) {
            decodedData = [[NSData alloc] initWithBase64EncodedString:token2 options:NSDataBase64DecodingIgnoreUnknownCharacters];
            if (decodedData == nil) return nil;
        }
    }
    
    NSString *decodedJson = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return [[KWSMetadata alloc] initWithJsonString:decodedJson];
}

@end
