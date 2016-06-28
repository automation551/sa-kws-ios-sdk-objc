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

#define TOKEN @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjk5MiwiYXBwSWQiOjMxMywiY2xpZW50SWQiOiJzYS1tb2JpbGUtYXBwLXNkay1jbGllbnQtMCIsInNjb3BlIjoidXNlciIsImlhdCI6MTQ2NzExNDk1MCwiZXhwIjoxNDY3MjAxMzUwLCJpc3MiOiJzdXBlcmF3ZXNvbWUifQ.ZsHbFPpj7HX8c51tmtI5ktJyoaSEw00GT0fRuhsOxDE"
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

- (void) isAllowedToRegisterForRemoteNotifications {
    [KWSLogger log:@"isAllowedToRegisterForRemoteNotifications"];
    [[KWS sdk] registerForRemoteNotifications];
}

- (void) isAlreadyRegisteredForRemoteNotifications {
    [KWSLogger log:@"isAlreadyRegisteredForRemoteNotifications"];
}

- (void) didRegisterForRemoteNotifications {
    [KWSLogger log:@"didRegisterForRemoteNotifications"];
}

- (void) didFailBecauseKWSDoesNotAllowRemoteNotifications {
    [KWSLogger log:@"didFailBecauseKWSDoesNotAllowRemoteNotifications"];
}

- (void) didFailBecauseParentEmailIsInvalid {
    [KWSLogger log:@"didFailBecauseParentEmailIsInvalid"];
}

- (void) didFailBecauseKWSCouldNotFindParentEmail {
    [[KWS sdk] submitParentEmail:@"dev.gabriel.coman@gmail.com"];
}

- (void) didFailBecauseRemoteNotificationsAreDisabled {
    [KWSLogger log:@"didFailBecauseRemoteNotificationsAreDisabled"];
}

- (void) didFailBecauseOfError {
    [KWSLogger log:@"didFailBecauseOfError"];
}

- (void) didFailBecauseFirebaseIsNotSetupCorrectly {
    [KWSLogger log:@"didFailBecauseFirebaseIsNotSetupCorrectly"];
}

@end
