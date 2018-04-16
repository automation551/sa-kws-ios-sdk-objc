//
//  KWSWebAuthResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 16/04/2018.
//

import Foundation
import SafariServices

public let kCloseSafariViewControllerNotification = "kCloseSafariViewControllerNotification"

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(saCallback(_:)), name: Notification.Name(rawValue: kCloseSafariViewControllerNotification), object: nil)
        
        safariVC = SFSafariViewController(url: authURL)
        safariVC!.delegate = self
        parent.present(safariVC!, animated: true, completion: nil)
    }
    
    @objc func saCallback(_ notification: NSNotification) {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(kCloseSafariViewControllerNotification), object: nil)
        
        if let authCode = notification.userInfo {
            callback?(authCode["code"] as! String)
        } else {
            callback?(nil)
        }
        
        parentRef.dismiss(animated: true, completion: nil)
    }
}
