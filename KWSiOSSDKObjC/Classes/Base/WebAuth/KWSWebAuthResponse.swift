//
//  KWSWebAuthResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 16/04/2018.
//

import Foundation
import SafariServices

let kCloseSafariViewControllerNotification = "kCloseSafariViewControllerNotification"

class KWSWebAuthResponse: UIViewController, SFSafariViewControllerDelegate {
    
    var safariVC: SFSafariViewController?
    var callback: ((String?) -> ())? = nil
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public required init(authURL: URL,
                          parent: UIViewController,
                          completionHandler: @escaping (String?) -> ()){
        super.init(nibName: nil, bundle: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(saCallback(_:)), name: Notification.Name(kCloseSafariViewControllerNotification), object: nil)
        safariVC = SFSafariViewController(url: authURL)
        safariVC!.delegate = self
        parent.present(safariVC!, animated: true, completion: nil)
    }
    
//    func setUp() {
//        NotificationCenter.default.addObserver(self, selector: #selector(KWSWebAuthResponse.saCallback(notification:)), name: NSNotification.Name(rawValue: kCloseSafariViewControllerNotification), object: nil)
//    }
    
    @objc func saCallback(_ notification: NSNotification) {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(kCloseSafariViewControllerNotification), object: nil)
        
        guard let url = notification.object as? URL else {
            return
        }
        
        // Parse url ...
    }
    
    // MARK: - SFSafariViewControllerDelegate
    // Called on "Done" button
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
