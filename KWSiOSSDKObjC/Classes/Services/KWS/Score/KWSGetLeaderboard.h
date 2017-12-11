//
//  KWSGetLeaderboard.h
//  Pods
//
//  Created by Gabriel Coman on 28/07/2016.
//
//

#import "KWSService.h"
#import "KWSLeaderboard.h"

typedef void (^KWSChildrenGetLeaderboardBlock)(NSArray<KWSLeader*> *leaders);

@interface KWSGetLeaderboard : KWSService
- (void) execute:(KWSChildrenGetLeaderboardBlock)gotleaderboard;
@end
