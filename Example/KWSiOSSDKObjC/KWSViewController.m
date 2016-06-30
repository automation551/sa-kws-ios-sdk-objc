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

#define TOKEN @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEwMDQsImFwcElkIjozMTMsImNsaWVudElkIjoic2EtbW9iaWxlLWFwcC1zZGstY2xpZW50LTAiLCJzY29wZSI6InVzZXIiLCJpYXQiOjE0NjcyOTY2MDksImV4cCI6MTQ2NzM4MzAwOSwiaXNzIjoic3VwZXJhd2Vzb21lIn0.T0Gy_BrN0MKuiEbadSb7AjpTiRcJ6MlalXx9JDAE8EI"
#define API @"https://kwsapi.demo.superawesome.tv/v1/"

@interface KWSViewController ()  <KWSProtocol>
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)startProcess:(id)sender {
    [[KWS sdk] setupWithOAuthToken:TOKEN kwsApiUrl:API andPermissionPopup:YES delegate:self];
    [[KWS sdk] checkIfNotificationsAreAllowed];
}

- (IBAction)unregisterProcess:(id)sender {
    [[KWS sdk] unregisterForRemoteNotifications];
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

- (void) kwsSDKDidUnregisterUserForRemoteNotifications {
    NSLog(@"User unregistered for Remote Notifications");
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
            [[KWS sdk] showParentEmailPopup];
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
        case CouldNotUnsubscribeInKWS: {
            NSLog(@"Could not unsubscribe in KWS");
            break;
        }
    }
}

@end
