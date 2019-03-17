//
//  Feed+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol FeedItemProtocol: ModelProtocol,
                                    UniqueIdentityTraitProtocol,
                                    PostedByUserTraitProtocol,
                                    LikeableTraitProtocol,
                                    CommentableTraitProtocol,
                                    ViewableTraitProtocol,
                                    ShareableTraitProtocol,
                                    ContainsImageTraitProtocol {
    
    var date: Double { get }
    var text: String? { get }
    var thumbnailSrc: String? { get }
    var videoDuration: Int { get }
    var videoSrc: [String] { get }
    var frontEndId: String? { get }
    var rejamOf: FeedItemProtocol? { get }
    var richContent: RichContentProtocol? { get }
    var stickerPositions: [StickerPositionProtocol] { get }
    var subItems: [FeedItemProtocol] { get }
}

public protocol RichContentProtocol: ModelProtocol, UniqueIdentityTraitProtocol {
    
    var contentType: String { get }
    var contentUrl: String? { get }
    var leaderboardUrl: String? { get }
    var requiresLandscape: Bool { get }
}
