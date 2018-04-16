//
//  AppDelegate.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 16/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import UIKit
import KWSiOSSDKObjC

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Before doing this, you should check the url is your redirect-uri before doing anything. Be safe :)
        if let components =  NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            let code = queryItems.first?.value {
            
            let nc = NotificationCenter.default
            nc.post(name:Notification.Name(rawValue:kCloseSafariViewControllerNotification),
                    object: nil,
                    userInfo: ["code":code])
            
            return true
        }
        return true
    }
}
