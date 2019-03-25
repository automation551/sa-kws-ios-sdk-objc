//
//  TraitProtocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol TraitProtocol {}

// MARK: Protocol that add unique ids, names, etc to an IModel subclass
public protocol UniqueIdentityTraitProtocol: TraitProtocol {
    var id: AnyHashable { get }
}

public protocol UniqueNameTraitProtocol: TraitProtocol {
    var name: String? { get }
}

// MARK: Protocol that add language support to an IModel subclass
public protocol MultiLanguageTraitProtocol: TraitProtocol {
    
    var language: String? { get }
}

// MARK: Protocols for IModels that contain like, comment, view, etc logic
public protocol LikeableTraitProtocol: TraitProtocol {
    
    var likeCount: Int { get set }
    var selfLiked: Bool { get set }
}

public protocol CommentableTraitProtocol: TraitProtocol {
    
    var commentCount: Int { get set }
}

public protocol ViewableTraitProtocol: TraitProtocol {
    
    var viewCount: Int { get set }
}

public protocol ShareableTraitProtocol: TraitProtocol {
    
    var rejamCount: Int { get set }
    var selfRejammed: Bool { get  set }
}

public protocol FollowedTraitProtocol: TraitProtocol {
    
    var followersCount: Int { get set }
    var isFollowed: Bool { get set }
}

public protocol FollowingTraitProtocol: TraitProtocol {
    
    var followedUsersCount: Int { get set }
    var isFollowing: Bool { get set }
}

// MARK: Protocols that contain linked data (a posting user, an associated feed item, etc..)
public protocol PostedByUserTraitProtocol: TraitProtocol {
    
    var postingUserId: String { get set }
    var postingUser: UserSocialDetailsProtocol? { get set }
}

public protocol LinkedToFeedItemTraitProtocol: TraitProtocol {
    
    var feedItemId: String? { get set }
    var feedItem: FeedItemProtocol? { get }
}

public protocol LinkedToMessageTraitProtocol: TraitProtocol {
    
    var messageId: String? { get }
    var text: String? { get }
}

public protocol ContainsImageTraitProtocol: TraitProtocol {
    
    var imageSrc: String? { get }
    var containsPhoto: Bool { get }
    var sticker: StickerProtocol? { get }
}

// MARK: Traits for lists and other repetitive models
public protocol ListTraitProtocol: TraitProtocol {
    
    var count: Int { get }
    var offset: Int { get }
    var limit: Int { get }
}
