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
#import "SALogger.h"
#import "SANetwork.h"
#import "KWSModel.h"
#import "SAUtils.h"

#define API @"https://kwsapi.demo.superawesome.tv/v1/"

@interface KWSViewController ()  <KWSProtocol>
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _token = NULL;
}

- (IBAction) createNewUser:(id)sender {
    
    NSString *url = @"https://kwsdemobackend.herokuapp.com/create";
    NSString *username = [NSString stringWithFormat:@"testuser_%d", [SAUtils randomNumberBetween:100 maxNumber:500]];
    NSDictionary *header = @{@"Content-Type":@"application/json"};
    NSDictionary *body = @{@"username":username,
                           @"password":@"testtest",
                           @"dateOfBirth":@"2011-03-02"};
    
    SANetwork *network = [[SANetwork alloc] init];
    [network sendPOST:url withQuery:@{} andHeader:header andBody:body andSuccess:^(NSInteger status, NSString *payload) {
        
        if (status == 200) {
            KWSModel *model = [[KWSModel alloc] initWithJsonString:payload];
            _token = model.token;
            NSLog(@"Created user %@ with token %@", username, _token);
        } else {
            NSLog(@"Could not create user %@", username);
        }
        
    } andFailure:^{
        NSLog(@"Could not create user %@", username);
    }];
}

- (IBAction) registerToken:(id)sender {
    if (_token == NULL) {
        NSLog(@"Please create a valid user before sending tokens");
    }
    else{
        [[KWS sdk] setupWithOAuthToken:_token kwsApiUrl:API andPermissionPopup:YES delegate:self];
        [[KWS sdk] registerForRemoteNotifications];
    }
}

- (IBAction) unregisterToken:(id)sender {
    [[KWS sdk] unregisterForRemoteNotifications];
}

- (IBAction)isRegistered {
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    BOOL isRegistered = (settings.types & UIRemoteNotificationTypeAlert);
    NSLog(@"Is registered %d", isRegistered);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// <KWSProtocol>

- (void) kwsSDKDidRegisterUserForRemoteNotifications {
    NSLog(@"User is registered for Remote Notifications");
}

- (void) kwsSDKDidUnregisterUserForRemoteNotifications {
    NSLog(@"User unregistered for Remote Notifications");
}

- (void) kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType {
    
    switch (errorType) {
        case KWS_ParentHasDisabledRemoteNotifications: {
            NSLog(@"KWS Error: Parent has disabled Remote Notification permissions");
            break;
        }
        case System_UserHasDisabledRemoteNotifications: {
            NSLog(@"System Error: User has disabled Remote Notification permissions");
            break;
        }
        case KWS_UserHasNoParentEmail: {
            NSLog(@"KWS Error: User has no parent email");
            [[KWS sdk] showParentEmailPopup];
            break;
        }
        case KWS_ParentEmailInvalid: {
            NSLog(@"KWS Error: Parent email is invalid");
            break;
        }
        case System_FirebaseNotSetup: {
            NSLog(@"System Error: Firebase is not setup");
            break;
        }
        case System_FirebaseCouldNotGetToken: {
            NSLog(@"System Error: Firebase could not get a token");
            break;
        }
        case Network_ErrorCheckingIfUserHasRemoteNotificationsEnabledInKWS: {
            NSLog(@"Network Error: Checking if user has Remote Notification enabled in KWS");
            break;
        }
        case Network_ErrorRequestingRemoteNotificationsPermissionInKWS: {
            NSLog(@"Network Error: Requesting Remote Notification permissions in KWS");
            break;
        }
        case Network_ErrorSubmittingParentEmail: {
            NSLog(@"Network Error: Submiting parent email to KWS");
            break;
        }
        case Network_ErrorSubscribingTokenToKWS: {
            NSLog(@"Network Error: Subscribing token to KWS");
            break;
        }
        case Network_ErrorUnsubscribingTokenFromKWS: {
            NSLog(@"Network Error: Unsubscribing token from KWS");
            break;
        }
    }
}

@end
