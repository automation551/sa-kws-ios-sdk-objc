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
#import "NotificationProcess.h"
#import "FirebaseGetToken.h"

#define API @"https://kwsapi.demo.superawesome.tv/v1/"

@interface KWSViewController ()
@property (nonatomic, strong) NSString *token;
@end

@implementation KWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _token = NULL;
    FirebaseGetToken *gt = [[FirebaseGetToken alloc] init];
    NSLog(@"At startup token is %@", [gt getSavedToken]);
}

- (IBAction) createNewUser:(id)sender {
    
    __block NSString *username = [NSString stringWithFormat:@"testuser_%ld", (long)[SAUtils randomNumberBetween:100 maxNumber:500]];
    
    [[KWS sdk] createUser:username withPassword:@"testtest" andDateOfBirth:@"2011-03-02" andCountry:@"US" :^(BOOL success, NSString *token) {
        
        if (success && token) {
            [[KWS sdk] setupWithOAuthToken:_token kwsApiUrl:API];
            
            NSLog(@"Created user %@ with token %@", username, _token);
        }
        
    }];
    
//    NSString *url = @"https://kwsdemobackend.herokuapp.com/create";
//    NSDictionary *header = @{@"Content-Type":@"application/json"};
//    NSDictionary *body = @{@"username":username,
//                           @"password":@"testtest",
//                           @"dateOfBirth":@"2011-03-02",
//                           @"country":@"US"};
//    
//    SANetwork *network = [[SANetwork alloc] init];
//    [network sendPOST:url withQuery:@{} andHeader:header andBody:body withResponse:^(NSInteger status, NSString *payload, BOOL success) {
//        if (!success) {
//            NSLog(@"Could not create user %@", username);
//        } else {
//            if (status == 200) {
//                // get user
//                KWSModel *model = [[KWSModel alloc] initWithJsonString:payload];
//                _token = model.token;
//                NSLog(@"Created user %ld - %@ with token %@", (long)model.userId, username, _token);
//                
//                // setup KWS
//                [[KWS sdk] setupWithOAuthToken:_token kwsApiUrl:API];
//            } else {
//                NSLog(@"Could not create user %@", username);
//            }
//        }
//    }];
}

- (IBAction) registerToken:(id)sender {
    
    if (_token == NULL) {
        NSLog(@"Please create a valid user before sending tokens");
    }
    else{
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
