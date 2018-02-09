//
//  KWSPermissions.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

#import "KWSPermissions.h"

@implementation KWSPermissions

- (id) initWithAccessAddress: (NSNumber *) accessAddress
          andAccessFirstName: (NSNumber *) accessFirstName
           andAccessLastName: (NSNumber *) accessLastName
              andAccessEmail: (NSNumber *) accessEmail
      andAccessStreetAddress: (NSNumber *) accessStreetAddress
               andAccessCity: (NSNumber *) accessCity
         andAccessPostalCode: (NSNumber *) accessPostalCode
            andAccessCountry: (NSNumber *) accessCountry
     andSendPushNotification: (NSNumber *) sendPushNotification
           andSendNewsletter: (NSNumber *) sendNewsletter
        andEnterCompetitions: (NSNumber *) enterCompetitions {
    
    self = [self init];
    
    if(self != nil) {
        
        _accessAddress = accessAddress;
        _accessPhoneNumber = @"";
        _accessFirstName = accessFirstName;
        _accessLastName = accessLastName;
        _accessEmail = accessEmail;
        _accessStreetAddress = accessStreetAddress;
        _accessCity = accessCity;
        _accessPostalCode = accessPostalCode;
        _accessCountry = accessCountry;
        _sendPushNotification = sendPushNotification;
        _sendNewsletter = sendNewsletter;
        
    }
    
    return self;
    
}

- (id) initWithJsonDictionary:(NSDictionary *)jsonDictionary {
    if (self = [super initWithJsonDictionary:jsonDictionary]){
        _accessAddress = [jsonDictionary safeObjectForKey:@"accessAddress"];
        _accessPhoneNumber = [jsonDictionary safeObjectForKey:@"accessPhoneNumber"];
        _accessFirstName = [jsonDictionary safeObjectForKey:@"accessFirstName"];
        _accessLastName = [jsonDictionary safeObjectForKey:@"accessLastName"];
        _accessEmail = [jsonDictionary safeObjectForKey:@"accessEmail"];
        _accessStreetAddress = [jsonDictionary safeObjectForKey:@"accessStreetAddress"];
        _accessCity = [jsonDictionary safeObjectForKey:@"accessCity"];
        _accessPostalCode = [jsonDictionary safeObjectForKey:@"accessPostalCode"];
        _accessCountry = [jsonDictionary safeObjectForKey:@"accessCountry"];
        _sendPushNotification = [jsonDictionary safeObjectForKey:@"sendPushNotification"];
        _sendNewsletter = [jsonDictionary safeObjectForKey:@"sendNewsletter"];
        _enterCompetitions = [jsonDictionary safeObjectForKey:@"enterCompetitions"];
        
        
    }
    return self;
}

- (BOOL) isValid {
    return true;
}

- (NSDictionary*) dictionaryRepresentation {
    return @{
             @"accessAddress": nullSafe(_accessAddress),
             @"accessPhoneNumber": nullSafe(_accessPhoneNumber),
             @"accessFirstName": nullSafe(_accessFirstName),
             @"accessLastName": nullSafe(_accessLastName),
             @"accessEmail": nullSafe(_accessEmail),
             @"accessStreetAddress": nullSafe(_accessStreetAddress),
             @"accessCity": nullSafe(_accessCity),
             @"accessPostalCode": nullSafe(_accessPostalCode),
             @"accessCountry": nullSafe(_accessCountry),
             @"sendPushNotification": nullSafe(_sendPushNotification),
             @"sendNewsletter": nullSafe(_sendNewsletter),
             @"enterCompetitions": nullSafe(_enterCompetitions)
             
             };
}

@end
