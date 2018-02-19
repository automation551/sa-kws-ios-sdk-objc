//
//  CreateUserResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

@objc(KWSCreateUserResponse)
public final class CreateUserResponse: NSObject {
    
    public let id:      Int?
    public let token:   String?
    
    public required init(id: Int?,
                         token: String? = "") {
        
        self.id = id
        self.token = token
        
    }    
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? CreateUserResponse else { return false }
        return self.id == object.id
    }
    
}