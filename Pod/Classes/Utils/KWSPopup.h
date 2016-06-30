//
//  KWSPopup.h
//  Pods
//
//  Created by Gabriel Coman on 30/06/2016.
//
//

#import <Foundation/Foundation.h>

// define a blocks used by UIAlertActions
typedef void(^actionBlock) (UIAlertAction *action);
typedef void(^okBlock) (NSString *popupMessage);
typedef void(^nokBlock) ();

@interface KWSPopup : NSObject

// show function
- (void) showWithTitle:(NSString*)title
            andMessage:(NSString*)message
            andOKTitle:(NSString*)ok
           andNOKTitle:(NSString*)nok
          andTextField:(BOOL)hasTextField
            andOKBlock:(okBlock)okBlock
           andNOKBlock:(nokBlock)nokBlock;

// close function
- (void) close;

@end
