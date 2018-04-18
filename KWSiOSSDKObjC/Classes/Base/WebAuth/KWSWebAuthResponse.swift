//
//  KWSWebAuthResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 16/04/2018.
//

import Foundation
import SafariServices

public class KWSWebAuthResponse: NSObject, SFSafariViewControllerDelegate {
    
    var safariVC: SFSafariViewController?
    var callback: ((String?) -> ())? = nil
    var parentRef: UIViewController!
    
    public required init(authURL: URL,
                         parent: UIViewController,
                         completionHandler: @escaping (String?) -> ()){
        super.init()
        
        callback = completionHandler
        parentRef = parent
        
        Notifications.addObserver(withObserver: self, handler: #selector(KWSWebAuthResponse.saCallback(_:)), notificationIdentifier: .item)
        
        safariVC = SFSafariViewController(url: authURL)
        safariVC!.delegate = self
        parent.present(safariVC!, animated: true, completion: nil)
    }
    
    @objc func saCallback(_ notification: NSNotification) {
        
        Notifications.removeObserver(withObserver: self, notificationIdentifier: .item)
        
        if let authCode = notification.userInfo {
            callback?(authCode["code"] as! String)
        } else {
            callback?(nil)
        }
        
        parentRef.dismiss(animated: true, completion: nil)
    }
}
