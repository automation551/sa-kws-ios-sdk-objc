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
@property (nonatomic, strong) requested requested;
@property (nonatomic, strong) NSMutableArray<NSString*> *requestedPermissions;
@end

@implementation KWSRequestPermission

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
        _requested(false, false);
    } else {
        if (payload) {
            KWSError *error = [[KWSError alloc] initWithJsonString:payload];
            [SALogger log:[error jsonPreetyStringRepresentation]];
            
            if (status == 200 || status == 204) {
                _requested(true, true);
            }
            else if (status != 200 && error) {
                if (error.code == 10 && error.invalid.parentEmail.code == 6) {
                    _requested(true, false);
                }
                else {
                    _requested(false, false);
                }
            }
            else {
                _requested(false, false);
            }
        } else {
            _requested(false, false);
        }
    }
    
}

- (void) execute:(NSArray<NSNumber *> *)requestPermissions :(requested)requested{

    _requested = requested ? requested : ^(BOOL success, BOOL requested){};
    
    _requestedPermissions = [[NSMutableArray alloc] init];
    for (NSNumber *number in requestPermissions) {
        NSInteger typeAsInt = [number integerValue];
        [_requestedPermissions addObject:[self typeToString:typeAsInt]];
    }
    
    // call to super
    [super execute:requestPermissions];
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

@end
