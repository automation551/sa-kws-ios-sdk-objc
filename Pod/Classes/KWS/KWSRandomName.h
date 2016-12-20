//
//  KWSRandomName.h
//  Pods
//
//  Created by Gabriel Coman on 20/12/2016.
//
//

#import <Foundation/Foundation.h>
#import "KWSRequest.h"

@protocol KWSRandomNameProtocol <NSObject>

- (void) didGetRandomName: (NSString*) name;

@end

@interface KWSRandomName : KWSRequest
@property (nonatomic, weak) id <KWSRandomNameProtocol> delegate;

- (void) execute:(NSInteger)appId:(id)param;

@end
