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
#import "KWSChildren.h"
#import "SANetwork.h"

// models
#import "KWSMetadata.h"
#import "KWSError.h"
#import "KWSParentEmailError.h"
#import "KWSInvalid.h"

@interface KWSRequestPermission ()
@property (nonatomic, strong) KWSChildrenRequestPermissionBlock requested;
@property (nonatomic, strong) NSMutableArray<NSString*> *requestedPermissions;
@end

@implementation KWSRequestPermission

- (id) init {
    if (self = [super init]) {
        _requested = ^(KWSChildrenRequestPermissionStatus status) {};
    }
    
    return self;
}

- (NSString*) getEndpoint {
    return [NSString stringWithFormat:@"v1/users/%ld/request-permissions", (long)loggedUser.metadata.userId];
}

- (KWS_HTTP_METHOD) getMethod {
    return POST;
}

- (NSDictionary*) getBody {
    return @{
        @"permissions": nullSafe([_requestedPermissions dictionaryRepresentation])
    };
}

- (void) successWithStatus:(NSInteger)status andPayload:(NSString *)payload andSuccess:(BOOL)success {
    if (!success) {
        _requested(KWSChildren_RequestPermission_NetworkError);
    } else {
        if (payload) {
            KWSError *error = [[KWSError alloc] initWithJsonString:payload];
            NSLog(@"%@", [error jsonPreetyStringRepresentation]);
            
            if (status == 200 || status == 204) {
                _requested(KWSChildren_RequestPermission_Success);
            }
            else if (status != 200 && error) {
                if (error.code == 10 && error.invalid.parentEmail.code == 6) {
                    _requested(KWSChildren_RequestPermission_NoParentEmail);
                }
                else {
                    _requested(KWSChildren_RequestPermission_NetworkError);
                }
            }
            else {
                _requested(KWSChildren_RequestPermission_NetworkError);
            }
        } else {
            _requested(KWSChildren_RequestPermission_NetworkError);
        }
    }
    
}

- (void) execute:(NSArray<NSNumber *> *)requestPermissions :(KWSChildrenRequestPermissionBlock)requested{

    _requested = requested ? requested : _requested;
    
    _requestedPermissions = [[NSMutableArray alloc] init];
    for (NSNumber *number in requestPermissions) {
        NSInteger typeAsInt = [number integerValue];
        [_requestedPermissions addObject:[self typeToString:typeAsInt]];
    }
    
    // call to super
    [super execute:requestPermissions];
}

// MARK Aux functions

- (NSString*) typeToString:(KWSChildrenPermissionType)type {
    switch (type) {
        case KWSChildren_PermissionType_AccessEmail: return @"accessEmail";
        case KWSChildren_PermissionType_AccessAddress: return @"accessAddress";
        case KWSChildren_PermissionType_AccessFirstName: return @"accessFirstName";
        case KWSChildren_PermissionType_AccessLastName: return @"accessLastName";
        case KWSChildren_PermissionType_AccessPhoneNumber: return @"accessPhoneNumber";
        case KWSChildren_PermissionType_SendNewsletter: return @"sendNewsletter";
        case KWSChildren_PermissionType_SendPushNotification: return @"sendPushNotification";
    }
}

@end
