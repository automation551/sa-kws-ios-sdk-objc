//
//  UserAddress.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import UIKit

@objc(KWSSwiftUserAddress)
public final class UserAddress: NSObject {
    
    public let street: String?
    public let city: String?
    public let postCode: String?
    public let country: String?
   
    
    
    public required init(street: String?, city: String?, postCode: String?, country:String?) {
        
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
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserAddress else { return false }
        return self.street == object.street
    }
    
}
