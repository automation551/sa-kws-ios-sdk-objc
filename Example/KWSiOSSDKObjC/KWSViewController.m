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

#define DATA_TITLE @"title"
#define DATA_SEC @"section"

#define API @"https://kwsapi.demo.superawesome.tv/"
#define CLIENT_ID @"sa-mobile-app-sdk-client-0"
#define CLIENT_SECRET @"_apikey_5cofe4ppp9xav2t9"

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
                 DATA_SEC: @[@"Create user", @"Login user", @"Logoff user", @"Get user", @"Update user"]},
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
    [[KWS sdk] startSessionWithClientId:CLIENT_ID
                        andClientSecret:CLIENT_SECRET
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
                case 0: [self createNewUser]; break;
                case 1: [self authUser]; break;
                case 2: [self logoutUser]; break;
                case 3: [self getUserProfile]; break;
                case 4: [self updateUser]; break;
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

- (void) createNewUser {
    
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

- (void) authUser {
    [[KWS sdk] loginUser:@"testusr455" withPassword:@"testtest" andResponse:^(KWSAuthUserStatus status) {
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

- (void) logoutUser {
    [[KWS sdk] logoutUser];
}

- (void) getUserProfile {
    
    [[KWS sdk] getUser:^(KWSUser *user) {
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
        
        [[KWS sdk] updateUser:_user andResponse:^(BOOL updated) {
            NSLog(@"Updated user %d", updated);
        }];
    } else {
        NSLog(@"No user to update");
    }
}

- (void) submitParentEmail {
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

- (void) requestPermissions {
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

- (void) inviteUser {
    [[KWS sdk] inviteUser:@"gabriel.coman@superawesome.tv" andResponse:^(BOOL invited) {
        NSLog(@"Invited user %d", invited);
    }];
}

- (void) triggerEvent {
    [[KWS sdk] triggerEvent:@"a7tzV7QLhlR0rS8KK98QcZgrQk3ur260" withPoints:20 andResponse:^(BOOL success) {
        NSLog(@"Triggered event %d", success);
    }];
}

- (void) isTriggered {
    
}

- (void) getScore {
    [[KWS sdk] getScore:^(KWSScore *score) {
        NSLog(@"Current score %ld | %ld", (long)score.rank, (long)score.score);
    }];
}

- (void) getLeadrboard {
    [[KWS sdk] getLeaderboard:^(NSArray<KWSLeader *> *leaders) {
        NSLog(@"Leaders %@", [leaders jsonPrettyStringRepresentation]);
    }];
}

- (void) setAppData {
    [[KWS sdk] setAppData:@"app-data-1" withValue:20 andResponse:^(BOOL success) {
        NSLog(@"Set app data %d", success);
    }];
}

- (void) getAppData {
    [[KWS sdk] getAppData:^(NSArray<KWSAppData *> *appData) {
        NSLog(@"Get app data %@", appData);
    }];
}

- (void) enablePN {
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

- (void) disablePN {
     [[KWS sdk] unregister:NULL];
}

- (void) arePNEnabled {
    [[KWS sdk] isRegistered:^(BOOL success) {
        NSLog(@"Is registered %d", success);
    }];
}

@end
