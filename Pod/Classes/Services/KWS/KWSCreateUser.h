//
//  KWSCreateUser.h
//  Pods
//
//  Created by Gabriel Coman on 07/10/2016.
//
//

#import "KWSService.h"

typedef void (^created)(BOOL success, NSString* token);

@interface KWSCreateUser : KWSService
- (void) execute:(NSString*) username
     andPassword:(NSString*) password
  andDateOfBirth:(NSString*) dateOfBirth
      andCountry:(NSString*) country
                :(created) created;
@end
