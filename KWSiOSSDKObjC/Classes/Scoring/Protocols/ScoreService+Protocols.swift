//
//  ScoreService+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol ScoreServiceProtocol: ServiceProtocol {
    
    func getScore(appId: Int,
                  token: String,
                  completionHandler: @escaping(ScoreProtocol?, Error?) -> ())
    
    func getLeaderboard(appId: Int,
                        token: String,
                        completionHandler: @escaping(LeaderWrapperProtocol?, Error?) -> ())
}
