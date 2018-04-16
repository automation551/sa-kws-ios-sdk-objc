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
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func oAuthInit(authURL: URL){
        safariVC = SFSafariViewController(url: authURL)
        safariVC!.delegate = self
        self.present(safariVC!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: "saCallback:", name: NSNotification.Name(rawValue: kCloseSafariViewControllerNotification), object: nil)
    }
    
    func saCallback(notification: NSNotification) {
        // get the url form the auth callback
        let url = notification.object as! NSURL
        // then do whatever you like, for example :
        // get the code (token) from the URL
        // and do a request to get the information you need (id, name, ...)
        // Finally dismiss the Safari View Controller with:
        self.safariVC!.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - SFSafariViewControllerDelegate
    // Called on "Done" button
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
