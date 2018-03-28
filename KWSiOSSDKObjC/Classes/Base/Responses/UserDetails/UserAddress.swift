//
//  UserAddress.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

@objc(KWSSwiftUserAddress)
public final class UserAddress: NSObject, AddressModelProtocol {
    
    public var street: String?
    public var city: String?
    public var postCode: String?
    public var country: String?
    
    public required init(street:    String? = nil,
                         city:      String? = nil,
                         postCode:  String? = nil,
                         country:   String? = nil) {
        
        self.street = street
        self.city = city
        self.postCode = postCode
        self.country = country
        
    }
    
    public enum CodingKeys: String, CodingKey {
        
        //to encode
        case street
        case city
        case postCode
        case country
    }
    
    
    // MARK: - Equatable
    public static func ==(lhs: UserAddress, rhs: UserAddress) -> Bool {
        let areEqual = lhs.street == rhs.street
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserAddress else { return false }
        return self.street == object.street
    }
    
    public override var hash: Int {
        return street!.hashValue
    }
    
}
