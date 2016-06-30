//
//  KWSViewController.m
//  KWSiOSSDKObjC
//
//  Created by Gabriel Coman on 05/24/2016.
//  Copyright (c) 2016 Gabriel Coman. All rights reserved.
//

#import "KWSViewController.h"
#import "KWS.h"
#import "KWSMetadata.h"
#import "KWSLogger.h"

#define TOKEN @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEwMDIsImFwcElkIjozMTMsImNsaWVudElkIjoic2EtbW9iaWxlLWFwcC1zZGstY2xpZW50LTAiLCJzY29wZSI6InVzZXIiLCJpYXQiOjE0NjcyODQ4NjAsImV4cCI6MTQ2NzM3MTI2MCwiaXNzIjoic3VwZXJhd2Vzb21lIn0.wzlQgJ8LgfwztapSFSpVO_H1NLeK4vt1eUfXffdNEp0"
#define API @"https://kwsapi.demo.superawesome.tv/v1/"

@interface KWSViewController ()  <KWSProtocol>
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)startProcess:(id)sender {
    [[KWS sdk] setupWithOAuthToken:TOKEN kwsApiUrl:API delegate:self];
    [[KWS sdk] checkIfNotificationsAreAllowed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// <KWSProtocol>

- (void) kwsSDKDoesAllowUserToRegisterForRemoteNotifications {
    [[KWS sdk] registerForRemoteNotifications];
}

- (void) kwsSDKDidRegisterUserForRemoteNotifications {
    NSLog(@"User is registered for Remote Notifications");
}

- (void) kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType {
    switch (errorType) {
        case NoKWSPermission: {
            NSLog(@"KWS does not allow this user to have Remote Notifications");
            break;
        }
        case NoSystemPermission: {
            NSLog(@"User has disabled Remote Notifications");
            break;
        }
        case ParentEmailNotFound: {
            [[KWS sdk] submitParentEmail:@"dev.gabriel.coman@gmail.com"];
            break;
        }
        case ParentEmailInvalid: {
            NSLog(@"Parent email is invalid");
            break;
        }
        case FirebaseNotSetup: {
            NSLog(@"Firebase is not setup");
            break;
        }
        case FirebaseCouldNotGetToken: {
            NSLog(@"Firebase was not able to obtain a token");
            break;
        }
        case NetworkError: {
            NSLog(@"Other network error");
            break;
        }
    }
}

@end
