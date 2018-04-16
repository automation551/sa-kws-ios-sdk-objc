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
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        // Before doing this, you should check the url is your redirect-uri before doing anything. Be safe :)
        if let components =  NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            let code = queryItems.first?.value {
            
            // Let's find the instance of our authentication controller,
            // it would be the presentedViewController. This is another
            // reason to check before that we are actually coming from the SFSafariViewController
            if let rootViewController = window?.rootViewController,
                let viewController = rootViewController.presentedViewController as? KWSSwiftTableViewController {
                viewController.authWithCode(code: code)
            }
            
            return true
        }
        
        return true
    }
}
