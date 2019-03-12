//
//  UpdateUserDetailsFakeResponseModel.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit

//FAKE DECODER
public final class UpdateUserDetailsFakeResponseModel: NSObject, Error, Codable {
    
    public let userUpdated: Bool?
    public let emailUpdated: Bool?
    public let permissionsRequested: Bool?
    
    
    // MARK: - Initialization
    
    public required init(userUpdated:    Bool?  = false,
                         emailUpdated:   Bool?  = false,
                         permissionsRequested:   Bool?  = false) {
        self.userUpdated = userUpdated
        self.emailUpdated = emailUpdated
        self.permissionsRequested = permissionsRequested
    }
    
    enum CodingKeys: String, CodingKey {
        case userUpdated
        case emailUpdated
        case permissionsRequested
    }
}

extension AppConfigModel: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userUpdated = try values.decode(Bool.self, forKey: .userUpdated)
        emailUpdated = try values.decode(Bool.self, forKey: .emailUpdated)
        permissionsRequested = try values.decode(Bool.self, forKey: .permissionsRequested)
    }
}

