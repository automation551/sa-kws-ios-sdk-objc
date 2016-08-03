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

@interface KWSViewController ()  <KWSRegisterProtocol, KWSUnregisterProtocol, KWSCheckProtocol>
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _token = NULL;
}

- (IBAction) createNewUser:(id)sender {
    
    NSString *url = @"https://kwsdemobackend.herokuapp.com/create";
    NSString *username = [NSString stringWithFormat:@"testuser_%ld", (long)[SAUtils randomNumberBetween:100 maxNumber:500]];
    NSDictionary *header = @{@"Content-Type":@"application/json"};
    NSDictionary *body = @{@"username":username,
                           @"password":@"testtest",
                           @"dateOfBirth":@"2011-03-02"};
    
    SANetwork *network = [[SANetwork alloc] init];
    [network sendPOST:url withQuery:@{} andHeader:header andBody:body andSuccess:^(NSInteger status, NSString *payload) {
        
        if (status == 200) {
            // get user
            KWSModel *model = [[KWSModel alloc] initWithJsonString:payload];
            _token = model.token;
            NSLog(@"Created user %ld - %@ with token %@", (long)model.userId, username, _token);
            
            // setup KWS
            [[KWS sdk] setupWithOAuthToken:_token kwsApiUrl:API andPermissionPopup:YES];
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
        [[KWS sdk] registerForRemoteNotifications:self];
    }
}

- (IBAction) unregisterToken:(id)sender {
    [[KWS sdk] unregisterForRemoteNotifications:self];
}

- (IBAction)isRegistered {
    [[KWS sdk] userIsRegistered:self];
}

- (IBAction)getUserProfile:(id)sender {
//    [[KWS sdk] getUserProfile];
}

- (IBAction)sendParentEmail:(id)sender {
    [[KWS sdk] submitParentEmail:@"gabriel.coman@superawesome.tv"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// <KWSRegisterProtocol>

- (void) kwsSDKDidRegisterUserForRemoteNotifications {
    NSLog(@"User is registered for Remote Notifications");
}

- (void) kwsSDKDidFailToRegisterUserForRemoteNotificationsWithError:(KWSErrorType)errorType {
    
    switch (errorType) {
        case ParentHasDisabledRemoteNotifications: {
            NSLog(@"KWS Error: Parent has disabled Remote Notification permissions");
            break;
        }
        case UserHasDisabledRemoteNotifications: {
            NSLog(@"System Error: User has disabled Remote Notification permissions");
            break;
        }
        case UserHasNoParentEmail: {
            NSLog(@"KWS Error: User has no parent email");
            [[KWS sdk] showParentEmailPopup];
            break;
        }
        case ParentEmailInvalid: {
            NSLog(@"KWS Error: Parent email is invalid");
            break;
        }
        case FirebaseNotSetup: {
            NSLog(@"System Error: Firebase is not setup");
            break;
        }
        case FirebaseCouldNotGetToken: {
            NSLog(@"System Error: Firebase could not get a token");
            break;
        }
        case FailedToCheckIfUserHasNotificationsEnabledInKWS: {
            NSLog(@"Network Error: Checking if user has Remote Notification enabled in KWS");
            break;
        }
        case FailedToRequestNotificationsPermissionInKWS: {
            NSLog(@"Network Error: Requesting Remote Notification permissions in KWS");
            break;
        }
        case FailedToSubmitParentEmail: {
            NSLog(@"Network Error: Submiting parent email to KWS");
            break;
        }
        case FailedToSubscribeTokenToKWS: {
            NSLog(@"Network Error: Subscribing token to KWS");
            break;
        }
    }
}

// <KWSUnregisterProtocol>

- (void) kwsSDKDidUnregisterUserForRemoteNotifications {
    NSLog(@"User unregistered for Remote Notifications");
}

- (void) kwsSDKDidFailToUnregisterUserForRemoteNotifications {
    NSLog(@"Network Error: Unsubscribing token from KWS");
}

// <KWSCheckProtocol>

- (void) kwsSDKUserIsRegistered {
    NSLog(@"User is registered to KWS");
}

- (void) kwsSDKUserIsNotRegistered {
    NSLog(@"User is not registered to KWS");
}

- (void) kwsSDKDidFailToCheckIfUserIsRegistered {
    NSLog(@"Network Error: Checking if user is registered or not");
}

@end
