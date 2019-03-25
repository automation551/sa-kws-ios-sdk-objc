//
//  UserAddress.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

public struct UserAddressModel: Equatable, AddressProtocol, Codable {
    
    public var street: String?
    public var city: String?
    public var postCode: String?
    public var country: String?
    public var countryCode: String?
    public var countryName: String?
    
    public init(street: String?,
                city: String?,
                postCode: String?,
                country: String?,
                countryCode: String?,
                countryName: String?) {
        
        self.street = street
        self.city = city
        self.postCode = postCode
        self.country = country
        self.countryCode = countryCode
        self.countryName = countryName
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        street = try values.decodeIfPresent(String.self, forKey: .street) ?? nil
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? nil
        postCode = try values.decodeIfPresent(String.self, forKey: .postCode) ?? nil
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? nil
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode) ?? nil
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case postCode
        case country
        case countryCode
        case countryName
    }
}
