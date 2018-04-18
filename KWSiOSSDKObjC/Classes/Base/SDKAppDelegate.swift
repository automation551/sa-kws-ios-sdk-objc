//
//  SDKAppDelegate.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 18/04/2018.
//

import Foundation
import UIKit

public final class SDKAppDelegate {
    
    /// Returns the singleton instance of an application delegate.
    public static let shared = SDKAppDelegate()
    
    private init() { }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let components =  NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            let code = queryItems.first?.value {
            
            Notifications.postNotification(withNotificationIdentifier: .item, userInfo: ["code":code])
            
            return true
        }
        
        return false
    }
}
