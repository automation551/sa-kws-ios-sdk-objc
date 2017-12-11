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

typedef NS_ENUM(NSInteger, KWSChildrenUpdateParentEmailStatus) {
    KWSChildren_UpdateParentEmail_Success      = 0,
    KWSChildren_UpdateParentEmail_InvalidEmail = 1,
    KWSChildren_UpdateParentEmail_NetworkError = 2,
};

typedef void (^KWSChildrenUpdateParentEmailBlock)(KWSChildrenUpdateParentEmailStatus status);

@interface KWSParentEmail : KWSService
- (void) execute:(NSString*)email
                :(KWSChildrenUpdateParentEmailBlock)submitted;
@end
