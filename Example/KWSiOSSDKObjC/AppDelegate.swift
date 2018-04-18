//
//  AppDelegate.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 16/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit
import KWSiOSSDKObjC

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //connect to KWS SDK from SSO - returns false if not intended for KWS
        return KWSAppDelegate.shared.application(app, open: url, options: options)
    }
}
