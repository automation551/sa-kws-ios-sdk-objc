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

@interface KWSViewController ()  <KWSProtocol>

@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJhcHBJZCI6MiwiY2xpZW50SWQiOiJwb3BqYW0iLCJzY29wZSI6InVzZXIiLCJpYXQiOjE0NjU1NTIyODgsImV4cCI6MTQ2NTYzODY4OCwiaXNzIjoic3VwZXJhd2Vzb21lIn0.hDjdW4VAeV3-fJmxISrPDtqUixjb5vK2mxEe9oM8WzU";
    
    KWSMetadata *metadata = [[KWS sdk] getMetadata:token];
    NSLog(@"%@", [metadata jsonPreetyStringRepresentation] );
    
//    NSString *token00 = @"020-10-21021kjjksajklas";
//    NSString *token01 = @"89022jksjlaljkiouwqjnsasaljoisaoiwqoioiqw.jsajkjssu.hsjkajksajlsajlksa";
//    NSString *token1 = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjc0NCwiYXBwSWQiOjMxMywiY2xpZW50SWQiOiJzYS1tb2JpbGUtYXBwLXNkay1jbGllbnQtMCIsInNjb3BlIjoidXNlciIsImlhdCI6MTQ2NDA4NTUyMSwiZXhwIjoxNDY0MTcxOTIxLCJpc3MiOiJzdXBlcmF3ZXNvbWUifQ.dnzKjgkaUF3hjSlu22BtzBGBmuFchYVcXdicptUfSyI";
//    NSString *token3 = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjc0NiwiYXBwSWQiOjMxMywiY2xpZW50SWQiOiJzYS1tb2JpbGUtYXBwLXNkay1jbGllbnQtMCIsInNjb3BlIjoidXNlciIsImlhdCI6MTQ2NDA4MjQwMywiZXhwIjoxNDY0MTY4ODAzLCJpc3MiOiJzdXBlcmF3ZXNvbWUifQ.PEcEcUwKzB7YEMWXLSP8VqCn8yH01i-ZJtgtefDh7Fg";
    NSString *token4 = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjc0OSwiYXBwSWQiOjMxMywiY2xpZW50SWQiOiJzYS1tb2JpbGUtYXBwLXNkay1jbGllbnQtMCIsInNjb3BlIjoidXNlciIsImlhdCI6MTQ2NDY4NTMyMiwiZXhwIjoxNDY0NzcxNzIyLCJpc3MiOiJzdXBlcmF3ZXNvbWUifQ.B81dIuvFTyE9OQuEx_QuxtB9zugW7mMIW9DQJ2DlQcQ";
//
    [[KWS sdk] setupWithOAuthToken:token4 kwsApiUrl:@"https://kwsapi.demo.superawesome.tv/v1/" delegate:self];
//    [[KWS sdk] checkIfNotificationsAreAllowed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) isAllowedToRegisterForRemoteNotifications {
    [[KWS sdk] registerForRemoteNotifications];
}

- (void) isAlreadyRegisteredForRemoteNotifications {
    
}

- (void) didRegisterForRemoteNotifications {
    
}

- (void) didFailBecauseKWSDoesNotAllowRemoteNotifications {
    
}

- (void) didFailBecauseParentEmailIsInvalid {
    
}

- (void) didFailBecauseKWSCouldNotFindParentEmail {
    [[KWS sdk] submitParentEmail:@"dev.gabriel.coman@gmail.com"];
}

- (void) didFailBecauseRemoteNotificationsAreDisabled {
    
}

- (void) didFailBecauseOfError {
    
}

- (void) didFailBecauseFirebaseIsNotSetupCorrectly {
    
}

- (IBAction)doSomething:(id)sender {
    NSLog(@"Do something");
}

@end
