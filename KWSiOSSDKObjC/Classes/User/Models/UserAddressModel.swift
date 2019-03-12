//
//  UserAddress.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class UserAddressModel: NSObject, AddressModelProtocol, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case postCode
        case country
        case countryCode
        case countryName
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try values.decode(String.self, forKey: .street)
        self.city = try values.decode(String.self, forKey: .city)
        self.postCode = try values.decode(String.self, forKey: .postCode)
        self.country = try values.decode(String.self, forKey: .country)
        self.countryCode = try values.decode(String.self, forKey: .countryCode)
        self.countryName = try values.decode(String.self, forKey: .countryName)
    }
}
