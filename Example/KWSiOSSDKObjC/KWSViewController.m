//
//  KWSViewController.m
//  KWSiOSSDKObjC
//
//  Created by Gabriel Coman on 05/24/2016.
//  Copyright (c) 2016 Gabriel Coman. All rights reserved.
//

#import "KWSViewController.h"
#import "KWS.h"
#import "SALogger.h"
#import "SAUtils.h"


#define API @"https://kwsapi.demo.superawesome.tv/"
#define CLIENT_ID @"sa-mobile-app-sdk-client-0"
#define CLIENT_SECRET @"_apikey_5cofe4ppp9xav2t9"

@interface KWSViewController ()
@property (nonatomic, strong) KWSUser *user;
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KWS sdk] startSessionWithClientId:CLIENT_ID
                        andClientSecret:CLIENT_SECRET
                              andAPIUrl:API];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction) createNewUser:(id)sender {
    
    __block NSString *username = [NSString stringWithFormat:@"testusr%ld", (long)[SAUtils randomNumberBetween:100 maxNumber:500]];
    
    [[KWS sdk] createUser:username
             withPassword:@"testtest"
           andDateOfBirth:@"2011-03-02"
               andCountry:@"US"
           andParentEmail:@"dev.gabriel.coman@gmail.com"
              andResponse:^(KWSCreateUserStatus status) {
                             
                             switch (status) {
                                 case KWSCreateUser_Success: {
                                     NSLog(@"Created user & logged as %ld - %@ ",
                                           (long)[[KWS sdk] getLoggedUser]._id,
                                           [[KWS sdk] getLoggedUser].username);
                                     break;
                                 }
                                 case KWSCreateUser_NetworkError: {
                                     NSLog(@"Network error Creating user %@", username);
                                     break;
                                 }
                                 case KWSCreateUser_DuplicateUsername: {
                                     NSLog(@"Duplicate user %@", username);
                                     break;
                                 }
                                 default:
                                     break;
                             }
    }];
}

- (IBAction)authUser:(id)sender {
    [[KWS sdk] authenticateUser:@"testusr455" withPassword:@"testtest" andResponse:^(KWSAuthUserStatus status) {
        switch (status) {
            case KWSAuthUser_Success:
                NSLog(@"Logged in as testusr455");
                break;
            case KWSAuthUser_InvalidCredentials:
                NSLog(@"Invalid credentials");
                break;
            case KWSAuthUser_NetworkError:
                NSLog(@"Network error");
                break;
            default:
                break;
        }
    }];
}

- (IBAction) getUserProfile:(id)sender {
    
    [[KWS sdk] getUser:^(KWSUser *user) {
        _user = user;
        if (user) {
            NSLog(@"User %@", [user jsonPreetyStringRepresentation]);
        } else {
            NSLog(@"Could not get current user details!");
        }
    }];
    
}

- (IBAction)updateUser:(id)sender {
    
    if (_user) {
        
        _user.firstName = @"John";
        
        [[KWS sdk] updateUser:_user andResponse:^(BOOL updated) {
            NSLog(@"Updated user %d", updated);
        }];
    } else {
        NSLog(@"No user to update");
    }
}

- (IBAction)submitParentEmail:(id)sender {
    [[KWS sdk] submitParentEmail:@"dev.gabriel.coman@gmail.com" andResponse:^(KWSParentEmailStatus type) {
        switch (type) {
            case KWSParentEmail_Success:{
                NSLog(@"Updated parent email");
                break;
            }
            case KWSParentEmail_Invalid: {
                NSLog(@"Parent email invalid");
                break;
            }
            case KWSParentEmail_NetworkError:{
                NSLog(@"Parent email error");
                break;
            }
            default:
                break;
        }
    }];
}

- (IBAction)requestPermissions:(id)sender {
    [[KWS sdk] requestPermission:@[@(KWSPermission_AccessLastName)] andResponse:^(KWSPermissionStatus status) {
        switch (status) {
            case KWSPermission_Success: {
                NSLog(@"Requested permissions OK");
                break;
            }
            case KWSPermission_NoParentEmail: {
                NSLog(@"No parent email to request permissions");
                break;
            }
            case KWSPermission_NetworkError: {
                NSLog(@"Permission network error");
                break;
            }
            default:
                break;
        }
    }];
}

- (IBAction)inviteUser:(id)sender {
    [[KWS sdk] inviteUser:@"gabriel.coman@superawesome.tv" andResponse:^(BOOL invited) {
        NSLog(@"Invited user %d", invited);
    }];
}

- (IBAction)triggerEvent:(id)sender {
    [[KWS sdk] triggerEvent:@"a7tzV7QLhlR0rS8KK98QcZgrQk3ur260" withPoints:20 andResponse:^(BOOL success) {
        NSLog(@"Triggered event %d", success);
    }];
}

- (IBAction)isTriggered:(id)sender {
    
}

- (IBAction)getScore:(id)sender {
    [[KWS sdk] getScore:^(KWSScore *score) {
        NSLog(@"Current score %ld | %ld", (long)score.rank, (long)score.score);
    }];
}

- (IBAction)getLeadrboard:(id)sender {
    [[KWS sdk] getLeaderboard:^(NSArray<KWSLeader *> *leaders) {
        NSLog(@"Leaders %@", [leaders jsonPrettyStringRepresentation]);
    }];
}

- (IBAction)setAppData:(id)sender {
    [[KWS sdk] setAppData:@"app-data-1" withValue:20 andResponse:^(BOOL success) {
        NSLog(@"Set app data %d", success);
    }];
}

- (IBAction)getAppData:(id)sender {
    [[KWS sdk] getAppData:^(NSArray<KWSAppData *> *appData) {
        NSLog(@"Get app data %@", appData);
    }];
}

- (IBAction)enablePN:(id)sender {
    registered R = ^(KWSNotificationStatus status) {
        switch (status) {
            case KWSNotification_Success: {
                break;
            }
            case KWSNotification_NoParentEmail: {
                [[KWS sdk] submitParentEmailWithPopup:^(KWSParentEmailStatus status) {
                    switch (status) {
                        case KWSParentEmail_Success: {
                            [[KWS sdk] register:R];
                            break;
                        }
                        case KWSParentEmail_Invalid: {
                            break;
                        }
                        case KWSParentEmail_NetworkError: {
                            break;
                        }
                    }
                }];
                
                break;
            }
            default:
                break;
        }
    };
    [[KWS sdk] register:R];
}

- (IBAction)disablePN:(id)sender {
     [[KWS sdk] unregister:NULL];
}

- (IBAction)arePNEnabled:(id)sender {
    [[KWS sdk] isRegistered:^(BOOL success) {
        NSLog(@"Is registered %d", success);
    }];
}

@end
