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

#define API @"https://kwsapi.demo.superawesome.tv/v1/"

@interface KWSViewController ()
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
            [[KWS sdk] setupWithOAuthToken:_token kwsApiUrl:API];
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
        [[KWS sdk] register:^(BOOL success, KWSErrorType type) {
            NSLog(@"Registered %d ", success);
        }];
    }
}

- (IBAction) unregisterToken:(id)sender {
    [[KWS sdk] unregister:^(BOOL success) {
        NSLog(@"Unregistered %d", success);
    }];
}

- (IBAction)isRegistered {
    [[KWS sdk] isRegistered:^(BOOL success) {
        NSLog(@"Is registered %d", success);
    }];
}

- (IBAction)getUserProfile:(id)sender {
    [[KWS sdk] getUser:^(KWSUser *user) {
        // OK
    }];
}

- (IBAction)sendParentEmail:(id)sender {
    // do nothing
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
