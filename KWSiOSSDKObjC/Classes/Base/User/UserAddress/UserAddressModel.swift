//
//  UserAddress.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class UserAddressModel: NSObject, AddressModelProtocol {
    
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
    public static func ==(lhs: UserAddressModel, rhs: UserAddressModel) -> Bool {
        
        let areEqual = lhs.city == rhs.city
                && lhs.postCode == rhs.postCode
                && lhs.countryCode == rhs.countryCode
    
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserAddressModel else { return false }
        return self == object
    }
}
