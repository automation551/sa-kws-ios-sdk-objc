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
        [[KWS sdk] checkIfNotificationsAreAllowed];
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
