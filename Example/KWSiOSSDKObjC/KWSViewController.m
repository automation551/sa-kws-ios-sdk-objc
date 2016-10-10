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
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KWS sdk] startSessionWithClientId:CLIENT_ID
                        andClientSecret:CLIENT_SECRET
                              andAPIUrl:API];
    
}

- (IBAction) createNewUser:(id)sender {
    
    __block NSString *username = [NSString stringWithFormat:@"testusr_%ld", (long)[SAUtils randomNumberBetween:100 maxNumber:500]];
    
    [[KWS sdk] createUser:username
             withPassword:@"testtest"
           andDateOfBirth:@"2011-03-02"
               andCountry:@"US"
           andParentEmail:@"dev.gabriel.coman@gmail.com"
                         :^(BOOL success, KWSCreateUserError error) {
                             
        if (success) {
            NSLog(@"Created user %@ - %@",
                  [[KWS sdk] getLoggedUser].username,
                  [[KWS sdk] getLoggedUser].token);
        } else {
            NSLog(@"Failed to create & auth user");
        }
    }];
}

- (IBAction) registerToken:(id)sender {
    
    registered R = ^(BOOL success, KWSErrorType type) {
        if (success) {
            NSLog(@"Success registering!");
        } else {
            switch (type) {
                case UserHasNoParentEmail: {
                    [[KWS sdk] submitParentEmailWithPopup:^(BOOL success) {
                        if (success) {
                            [[KWS sdk] register:R];
                        }
                    }];
                    break;
                }
                default:break;
            }
        }
    };
    [[KWS sdk] register:R];
}

- (IBAction) unregisterToken:(id)sender {
    [[KWS sdk] unregister:NULL];
}

- (IBAction)isRegistered {
    [[KWS sdk] isRegistered:^(BOOL success) {
        NSLog(@"Is registered %d", success);
    }];
}

- (IBAction)getUserProfile:(id)sender {
    
    [[KWS sdk] getUser:^(KWSUser *user) {
        // user data
    }];
    
}


- (IBAction)getLeaderboard:(id)sender {
    [[KWS sdk] getLeaderboard:^(NSArray<KWSLeader *> *leaders) {
        NSLog(@"Leaders %@", [leaders jsonPrettyStringRepresentation]);
    }];
}

- (IBAction)triggerEvent:(id)sender {
    [[KWS sdk] triggerEvent:@"a7tzV7QLhlR0rS8KK98QcZgrQk3ur260" withPoints:20 andDescription:@"" :^(BOOL success) {
        NSLog(@"Triggered event %d", success);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
