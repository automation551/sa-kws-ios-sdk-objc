//
//  KWSWebAuthResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 16/04/2018.
//

import Foundation
import SafariServices

public class WebAuthController: NSObject, SFSafariViewControllerDelegate {
    
    var safariVC: SFSafariViewController?
    var callback: ((String?) -> ())? = nil
    var parentRef: UIViewController!
    
    public required init(authURL: URL,
                         parent: UIViewController,
                         completionHandler: @escaping (String?) -> ()){
        super.init()
        
        callback = completionHandler
        parentRef = parent
        
        initObserver()
        
        let customise = createVC (url: authURL)
        let viewController = customise(self)
        parent.present(viewController, animated: true, completion: nil)
    }
    
    private func initObserver(){
        Notifications.addObserver(withObserver: self, handler: #selector(WebAuthController.saCallback(_:)), notificationIdentifier: .item)
    }
    
    private func removeObserver(){
        Notifications.removeObserver(withObserver: self, notificationIdentifier: .item)
    }
    
    private func createVC(url: URL) -> (SFSafariViewControllerDelegate ) -> SFSafariViewController {
        return { delegate in
            let vc = SFSafariViewController(url: url)
            vc.delegate = delegate
            return vc
        }
    }
    
    
    @objc
    private func saCallback(_ notification: NSNotification) {
        
        removeObserver()
        
        if let authCode = notification.userInfo, let code: String = authCode["code"] as? String {
            callback?(code)
        } else {
            callback?(nil)
        }
        
        parentRef.dismiss(animated: true, completion: nil)
    }
}
