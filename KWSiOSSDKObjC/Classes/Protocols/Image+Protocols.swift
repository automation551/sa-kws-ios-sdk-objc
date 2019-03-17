//
//  Image+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol ImageModelProtocol: ModelProtocol, ContainsImageTraitProtocol {
    // empty implementation
}

public protocol StickerCoordinateProtocol: ModelProtocol {
    
    var x: Double { get }
    var y: Double { get }
}

public protocol StickerProtocol: ModelProtocol {
    
    var stickerPackId: String? { get }
    var stickerPackName: String? { get }
    var stickerId: String { get }
    var stickerUrl: String? { get }
}

public protocol StickerPositionProtocol: StickerProtocol {
    
    var giphyId: String? { get }
    var topLeft: StickerCoordinateProtocol { get }
    var bottomRight: StickerCoordinateProtocol { get }
    var rotationDegrees: Double { get }
    var zOrder: Int { get }
}
