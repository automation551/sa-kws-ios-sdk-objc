//
//  UserDetailsResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import UIKit

@objc(KWSUserDetailsResponse)
public final class UserDetailsResponse: NSObject {
    
    public let id: Int?
    public let username: String?
    public let firstName: String?
    public let lastName: String?
    public let address: UserAddress?
    public let dateOfBirth: String?
    public let gender: String?
    public let language: String?
    public let email: String?
    public let hasSetParentEmail: Bool?
    public let applicationProfile: ApplicationProfile?
    public let applicationPermissions: ApplicationPermissions?
    public let points: Points?
    public let createdAt: String?
    
    
    public required init(id: Int?, username: String?, firstName: String?, lastName:String?,
                         address: UserAddress?, dateOfBirth: String?, gender:String?,
                         language: String?, email: String?, hasSetParentEmail: Bool?,
                         applicationProfile: ApplicationProfile?, applicationPermissions: ApplicationPermissions?, points: Points?, createdAt: String?) {
        
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.language = language
        self.email = email
        self.hasSetParentEmail = hasSetParentEmail
        self.applicationProfile = applicationProfile
        self.applicationPermissions = applicationPermissions
        self.points = points
        self.createdAt = createdAt
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserDetailsResponse else { return false }
        return self.id == object.id
    }
    
}
