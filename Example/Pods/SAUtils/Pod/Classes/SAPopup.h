//
//  SAPopup.h
//  Pods
//
//  Created by Gabriel Coman on 07/07/2016.
//
//

#import <UIKit/UIKit.h>

// define a blocks used by UIAlertActions
typedef void(^actionBlock) (UIAlertAction *action);
typedef void(^okBlock) (NSString *popupMessage);
typedef void(^nokBlock) ();

@interface SAPopup : NSObject

// show function
- (void) showWithTitle:(NSString*)title
            andMessage:(NSString*)message
            andOKTitle:(NSString*)ok
           andNOKTitle:(NSString*)nok
          andTextField:(BOOL)hasTextField
       andKeyboardTyle:(UIKeyboardType)keyboardType
            andOKBlock:(okBlock)okBlock
           andNOKBlock:(nokBlock)nokBlock;

// close function
- (void) close;

@end