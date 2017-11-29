//
//  KWSViewController.m
//  KWSiOSSDKObjC
//
//  Created by Gabriel Coman on 05/24/2016.
//  Copyright (c) 2016 Gabriel Coman. All rights reserved.
//

#import "KWSViewController.h"
#import "KWSChildren.h"
#import "SAUtils.h"

#define DATA_TITLE @"title"
#define DATA_SEC @"section"

//#define API @"https://kwsapi.demo.superawesome.tv/"
//#define CLIENT_ID @"sa-mobile-app-sdk-client-0"
//#define CLIENT_SECRET @"_apikey_5cofe4ppp9xav2t9"

#define API @"https://stan-test-cluster.api.kws.superawesome.tv/"
#define CLIENT_ID  @"stan-test" // @"superawesomeclub"
#define CLIENT_SECRET  @"7Hpx255pMfdJD2IgmqMbM9Sz9O1AcrOd" // @"superawesomeclub"
#define CLIENT_MOBILE_SECRET @"DRYNvSStuSvnaDg0d3f9t17QybbpQqX4"

@interface KWSViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) KWSUser *user;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup data
    _data = [@[@{DATA_TITLE: @"User",
                 DATA_SEC: @[@"Random name", @"Create user", @"Login user", @"Logoff user", @"Get user", @"Update user"]},
               @{DATA_TITLE: @"Permissions",
                 DATA_SEC: @[@"Submit parent email", @"Request permissions"]},
               @{DATA_TITLE: @"Invite",
                 DATA_SEC: @[@"Invite another user"]},
               @{DATA_TITLE: @"Events",
                 DATA_SEC: @[@"Trigger event", @"Is triggered", @"Get score", @"Get leaderboard"]},
               @{DATA_TITLE: @"App data",
                 DATA_SEC: @[@"Set app data", @"Get app data"]},
               @{DATA_TITLE: @"Notifications",
                 DATA_SEC: @[@"Enable notifications", @"Disable notifications", @"Check if registered"]}] mutableCopy];
    
    // start KWS session
    [[KWSChildren sdk] setupWithClientId:CLIENT_ID
                         andClientSecret:CLIENT_MOBILE_SECRET
                               andAPIUrl:API];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [_data count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *item = [_data objectAtIndex:section];
    return [[item objectForKey:DATA_SEC] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *item = [_data objectAtIndex:section];
    return [item objectForKey:DATA_TITLE];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    
    NSDictionary *item = [_data objectAtIndex:[indexPath section]];
    NSArray *sections = [item objectForKey:DATA_SEC];
    NSString *title = [sections objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    switch (section) {
        // user
        case 0: {
            switch (row) {
                case 0: [self generateRandomName]; break;
                case 1: [self createNewUser]; break;
                case 2: [self authUser]; break;
                case 3: [self logoutUser]; break;
                case 4: [self getUserProfile]; break;
                case 5: [self updateUser]; break;
            }
            break;
        }
        // permissions
        case 1: {
            switch (row) {
                case 0: [self submitParentEmail]; break;
                case 1: [self requestPermissions]; break;
            }
            break;
        }
        // invite
        case 2: {
            switch (row) {
                case 0: [self inviteUser]; break;
            }
            break;
        }
        // events
        case 3: {
            switch (row) {
                case 0: [self triggerEvent]; break;
                case 1: [self isTriggered]; break;
                case 2: [self getScore]; break;
                case 3: [self getLeadrboard]; break;
            }
            break;
        }
        // app data
        case 4: {
            switch (row) {
                case 0: [self setAppData]; break;
                case 1: [self getAppData]; break;
            }
            break;
        }
        // notifications
        case 5:{
            switch (row) {
                case 0: [self enablePN]; break;
                case 1: [self disablePN]; break;
                case 2: [self arePNEnabled]; break;
            }
            break;
        }
    }
}

- (void) generateRandomName {
    [[KWSChildren sdk] getRandomUsername:^(NSString *name) {
        NSLog(@"Random name is %@", name);
    }];
}

- (void) createNewUser {
    
    __block NSString *username = [NSString stringWithFormat:@"testusr%ld", (long)[SAUtils randomNumberBetween:100 maxNumber:500]];
    
    [[KWSChildren sdk] createUser:username
             withPassword:@"testtest"
           andDateOfBirth:@"2011-03-02"
               andCountry:@"US"
           andParentEmail:@"dev.gabriel.coman@gmail.com"
              andResponse:^(KWSChildrenCreateUserStatus status) {
                             
                             switch (status) {
                                 case KWSChildren_CreateUser_Success: {
                                     NSLog(@"Created user & logged as %ld",
                                           (long)[[KWSChildren sdk] getLoggedUser].metadata.userId);
                                     break;
                                 }
                                 case KWSChildren_CreateUser_NetworkError: {
                                     NSLog(@"Network error Creating user %@", username);
                                     break;
                                 }
                                 case KWSChildren_CreateUser_DuplicateUsername: {
                                     NSLog(@"Duplicate user %@", username);
                                     break;
                                 }
                                 default:
                                     break;
                             }
    }];
}

- (void) authUser {
    [[KWSChildren sdk] loginUser:@"testusr371" withPassword:@"testtest" andResponse:^(KWSChildrenLoginUserStatus status) {
        switch (status) {
            case KWSChildren_LoginUser_Success:
                NSLog(@"Logged in as 'stanajdkfa'");
                break;
            case KWSChildren_LoginUser_InvalidCredentials:
                NSLog(@"Invalid credentials");
                break;
            case KWSChildren_LoginUser_NetworkError:
                NSLog(@"Network error");
                break;
            default:
                break;
        }
    }];
    
//    [[KWSChildren sdk] loginUser:@"stanajdkfa" withPassword:@"testtest" andResponse:^(KWSChildrenLoginUserStatus status) {
//        switch (status) {
//            case KWSChildren_LoginUser_Success:
//                NSLog(@"Logged in as 'stanajdkfa'");
//                break;
//            case KWSChildren_LoginUser_InvalidCredentials:
//                NSLog(@"Invalid credentials");
//                break;
//            case KWSChildren_LoginUser_NetworkError:
//                NSLog(@"Network error");
//                break;
//            default:
//                break;
//        }
//    }];
}

- (void) logoutUser {
    [[KWSChildren sdk] logoutUser];
}

- (void) getUserProfile {
    
    [[KWSChildren sdk] getUser:^(KWSUser *user) {
        _user = user;
        if (user) {
            NSLog(@"User %@", [user jsonPreetyStringRepresentation]);
        } else {
            NSLog(@"Could not get current user details!");
        }
    }];
    
}

- (void) updateUser {
    
    if (_user) {
        
        _user.firstName = @"John";
        
        [[KWSChildren sdk] updateUser:_user withResponse:^(BOOL updated) {
            NSLog(@"Updated user %d", updated);
        }];
    } else {
        NSLog(@"No user to update");
    }
}

- (void) submitParentEmail {
    [[KWSChildren sdk] updateParentEmail:@"dev.gabriel.coman@gmail.com"
                            withResponse:^(KWSChildrenUpdateParentEmailStatus type) {
        switch (type) {
            case KWSChildren_UpdateParentEmail_Success:{
                NSLog(@"Updated parent email");
                break;
            }
            case KWSChildren_UpdateParentEmail_InvalidEmail: {
                NSLog(@"Parent email invalid");
                break;
            }
            case KWSChildren_UpdateParentEmail_NetworkError:{
                NSLog(@"Parent email error");
                break;
            }
            default:
                break;
        }
    }];
}

- (void) requestPermissions {
    [[KWSChildren sdk] requestPermission:@[
                                           @(KWSChildren_PermissionType_AccessFirstName),
                                           @(KWSChildren_PermissionType_AccessLastName),
                                           @(KWSChildren_PermissionType_AccessAddress)] withResponse:^(KWSChildrenRequestPermissionStatus status) {
        switch (status) {
            case KWSChildren_RequestPermission_Success: {
                NSLog(@"Requested permissions OK");
                break;
            }
            case KWSChildren_RequestPermission_NoParentEmail: {
                NSLog(@"No parent email to request permissions");
                break;
            }
            case KWSChildren_RequestPermission_NetworkError: {
                NSLog(@"Permission network error");
                break;
            }
            default:
                break;
        }
    }];
}

- (void) inviteUser {
    [[KWSChildren sdk] inviteUser:@"gabriel.coman@superawesome.tv" withResponse:^(BOOL invited) {
        NSLog(@"Invited user %d", invited);
    }];
}

- (void) triggerEvent {
    [[KWSChildren sdk] triggerEvent:@"a7tzV7QLhlR0rS8KK98QcZgrQk3ur260" withPoints:20 andResponse:^(BOOL success) {
        NSLog(@"Triggered event %d", success);
    }];
}

- (void) isTriggered {
    
}

- (void) getScore {
    [[KWSChildren sdk] getScore:^(KWSScore *score) {
        NSLog(@"Current score %ld | %ld", (long)score.rank, (long)score.score);
    }];
}

- (void) getLeadrboard {
    [[KWSChildren sdk] getLeaderboard:^(NSArray<KWSLeader *> *leaders) {
        NSLog(@"Leaders %@", [leaders jsonPrettyStringRepresentation]);
    }];
}

- (void) setAppData {
    [[KWSChildren sdk] setAppData:20 forName:@"app-data-1" andResponse:^(BOOL success) {
        NSLog(@"Set app data %d", success);
    }];
}

- (void) getAppData {
    [[KWSChildren sdk] getAppData:^(NSArray<KWSAppData *> *appData) {
        NSLog(@"Get app data %@", appData);
    }];
}

- (void) enablePN {
    KWSChildrenRegisterForRemoteNotificationsBlock R = ^(KWSChildrenRegisterForRemoteNotificationsStatus status) {
        switch (status) {
            case KWSChildren_RegisterForRemoteNotifications_Success: {
                break;
            }
            case KWSChildren_RegisterForRemoteNotifications_NoParentEmail: {
                
               
                
//                [[KWSChildren sdk] submitParentEmailWithPopup:^(KWSChildrenUpdateParentEmailStatus status) {
//                    switch (status) {
//                        case KWSChildren_UpdateParentEmail_Success: {
//                            [[KWSChildren sdk] registerForRemoteNotifications:R];
//                            break;
//                        }
//                        case KWSChildren_UpdateParentEmail_InvalidEmail: {
//                            break;
//                        }
//                        case KWSChildren_UpdateParentEmail_NetworkError: {
//                            break;
//                        }
//                    }
//                }];
                
                break;
            }
            default:
                break;
        }
    };
    [[KWSChildren sdk] registerForRemoteNotifications:R];
}

- (void) disablePN {
     [[KWSChildren sdk] unregisterForRemoteNotifications:NULL];
}

- (void) arePNEnabled {
    [[KWSChildren sdk] isRegisteredForRemoteNotifications:^(BOOL success) {
        NSLog(@"Is registered %d", success);
    }];
}

@end
