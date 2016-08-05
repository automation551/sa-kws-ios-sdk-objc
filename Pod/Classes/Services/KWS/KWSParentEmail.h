//
//  KWSParentEmail.h
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//  @brief:
//  This module is used to send a parent email to the KWS backend
//

#import <UIKit/UIKit.h>
#import "KWSService.h"

typedef void (^submitted)(BOOL success);

@interface KWSParentEmail : KWSService
- (void) execute:(NSString*)email :(submitted)submitted;
@end
