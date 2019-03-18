//
//  BaseProtocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol ModelProtocol {}
public protocol ServiceProtocol {}
public protocol ConfigModelProtocol: ModelProtocol {}
public protocol ImageProtocol: ModelProtocol, ContainsImageTraitProtocol {}

public protocol BaseErrorModelProtocol: ModelProtocol {
    var message: String? { get }
}

public protocol UserSocialDetailsProtocol: ModelProtocol,
                                            UniqueIdentityTraitProtocol,
                                            UniqueNameTraitProtocol,
                                            MultiLanguageTraitProtocol,
                                            FollowedTraitProtocol,
                                            FollowingTraitProtocol {
    
    var bio: String? { get }
    var profileColour: Int64? { get }
    var isLoggedUser: Bool { get set }
    var isStaff: Bool { get }
    var isPartner: Bool { get }
    var isPrivate: Bool { get }
    var isUltra: Bool { get }
    var isDummy: Bool { get }
    var joinedAt: Double { get }
    var country: String? { get }
    var postCount: Int { get }
    var userLevel: Int { get }
    var profileImage: ImageProtocol? { get }
    var feedBackground: ImageProtocol? { get }
    var profileBackground: ImageProtocol? { get }
}
