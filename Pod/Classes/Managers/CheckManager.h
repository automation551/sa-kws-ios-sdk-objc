//
//  CheckManager.h
//  Pods
//
//  Created by Gabriel Coman on 12/07/2016.
//
//

#import <UIKit/UIKit.h>

@protocol CheckManagerProtocol <NSObject>

- (void) pushAllowedOverall;
- (void) pushDisabledOverall;
- (void) networkErrorTryingToCheckUserStatus;

@end

@interface CheckManager : NSObject

// singleton
+ (instancetype) sharedInstance;

// delegate
@property (nonatomic, weak) id<CheckManagerProtocol> delegate;

// main function
- (void) areNotificationsEnabled;

@end
