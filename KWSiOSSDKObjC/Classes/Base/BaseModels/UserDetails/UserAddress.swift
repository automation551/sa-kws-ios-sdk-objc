//
//  UserAddress.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class UserAddress: NSObject, AddressModelProtocol {
    
    public var street:      String?
    public var city:        String?
    public var postCode:    String?
    public var country:     String?
    public var countryCode: String?
    public var countryName: String?
    
    public required init(street:        String? = nil,
                         city:          String? = nil,
                         postCode:      String? = nil,
                         country:       String? = nil,
                         countryCode:   String? = nil,
                         countryName:   String? = nil) {
        
        self.street = street
        self.city = city
        self.postCode = postCode
        self.country = country
        self.countryCode = countryCode
        self.countryName = countryName
    }
    
    // MARK: - Equatable
    public static func ==(lhs: UserAddress, rhs: UserAddress) -> Bool {
        let areEqual = lhs.street == rhs.street
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserAddress else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return street!.hashValue
    }
}
