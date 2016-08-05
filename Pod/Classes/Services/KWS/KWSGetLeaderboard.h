//
//  KWSGetLeaderboard.h
//  Pods
//
//  Created by Gabriel Coman on 28/07/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSRequest.h"
#import "KWSLeaderboard.h"

// callback
typedef void (^gotLeaderboard)(NSArray<KWSLeader*> *leaders);

@interface KWSGetLeaderboard : KWSRequest
- (void) execute:(gotLeaderboard)gotleaderboard;
@end
