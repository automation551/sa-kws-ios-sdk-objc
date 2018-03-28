//
//  RandomUsernameService.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase

@objc public protocol RandomUsernameService: BaseService {
    
    func getRandomUsername(callback: @escaping(RandomUsername?,Error?) -> () )
    
}
