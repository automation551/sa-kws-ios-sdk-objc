//
//  KWSRequestPermission.m
//  Pods
//
//  Created by Gabriel Coman on 24/05/2016.
//
//

// header
#import "KWSRequestPermission.h"

// aux
#import "KWS.h"
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"
#import "SALogger.h"

@interface KWSRequestPermission ()
@property (nonatomic, assign) requested requested;
@property (nonatomic, strong) NSMutableArray<NSString*> *requestedPermissions;
@end

@implementation KWSRequestPermission

// MARK: Main functions

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"users/%ld/request-permissions", (long)metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"permissions": [_requestedPermissions dictionaryRepresentation]
    };
}

- (void) successWithStatus:(int)status andPayload:(NSString *)payload {
    if (payload) {
        KWSError *error = [[KWSError alloc] initWithJsonString:payload];
        [SALogger log:[error jsonPreetyStringRepresentation]];
        
        if (status == 200 || status == 204) {
            [self delPushPermissionRequestedInKWS];
        }
        else if (status != 200 && error) {
            if (error.code == 5 && error.invalid.parentEmail.code == 6) {
                [self delParentEmailIsMissingInKWS];
            }
            else {
                [self delParentPermissionError];
            }
        }
        else {
            [self delParentPermissionError];
        }
    } else {
        [self delParentPermissionError];
    }
}

- (void) failure {
    [self delParentPermissionError];
}

- (void) execute:(NSArray<NSNumber *> *)param :(requested)requested {
    
    // get parameter and check is correct type
    if ([param isKindOfClass:[NSArray class]]) {
        _requestedPermissions = [[NSMutableArray alloc] init];
        for (NSNumber *number in param) {
            NSInteger typeAsInt = [number integerValue];
            [_requestedPermissions addObject:[self typeToString:typeAsInt]];
        }
    } else {
        [self delParentPermissionError];
        return;
    }
    
    // get callback
    _requested = requested;
    
    // call to super
    [super execute:param];
}

// MARK Aux functions

- (NSString*) typeToString:(KWSPermissionType)type {
    switch (type) {
        case accessEmail: return @"accessEmail";
        case accessAddress: return @"accessAddress";
        case accessFirstName: return @"accessFirstName";
        case accessLastName: return @"accessLastName";
        case accessPhoneNumber: return @"accessPhoneNumber";
        case sendNewsletter: return @"sendNewsletter";
        case sendPushNotification: return @"sendPushNotification";
    }
}

// MARK Delegate functions

- (void) delPushPermissionRequestedInKWS {
    if (_requested) {
        _requested(true, true);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(pushPermissionRequestedInKWS)]) {
//        [_delegate pushPermissionRequestedInKWS];
//    }
}

- (void) delParentEmailIsMissingInKWS {
    if (_requested) {
        _requested(true, false);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(parentEmailIsMissingInKWS)]) {
//        [_delegate parentEmailIsMissingInKWS];
//    }
}

- (void) delParentPermissionError {
    if (_requested) {
        _requested(false, false);
    }
//    if (_delegate != NULL && [_delegate respondsToSelector:@selector(permissionError)]) {
//        [_delegate permissionError];
//    }
}

@end
