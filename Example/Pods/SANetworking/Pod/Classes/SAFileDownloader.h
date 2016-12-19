//
//  SASequentialFileDownloader.h
//  Pods
//
//  Created by Gabriel Coman on 30/09/2016.
//
//

#import <UIKit/UIKit.h>

@class SADownloadItem;

// callback for generic success
typedef void (^seqDownloadResponse)(BOOL success, NSString* diskPath);

@interface SAFileDownloader : NSObject

// singleton instance (instead of init)
+ (instancetype) getInstance;

// public methods
- (void) downloadFileFrom:(NSString*)url
              andResponse:(seqDownloadResponse)response;

// other aux methods
- (void) cleanup;

@end
