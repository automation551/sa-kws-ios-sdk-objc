//
//  KWSWebAuthResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 16/04/2018.
//

import Foundation

import UIKit
import WebKit

public class WebAuthController: NSObject, SAWebViewControllerDelegate {
    
    private var callback: ((String?) -> ())? = nil
    private var parentRef: UIViewController!
    
    public required init(authURL: URL,
                         parent: UIViewController,
                         completionHandler: @escaping (String?) -> ()){
        super.init()
        
        callback = completionHandler
        parentRef = parent
        
        var webViewController = SAWebViewController(withURL: authURL)
        webViewController.delegate = self
        parentRef.present(webViewController, animated: true, completion: nil)
    }
    
    public func finishAuthWithCode(withCode code: String?) {
        callback?(code)
        parentRef.dismiss(animated: true, completion: nil)
    }
}

public protocol SAWebViewControllerDelegate: class {
    func finishAuthWithCode(withCode code: String?)
}

public class SAWebViewController: UIViewController {
    
    // MARK: Properties
    private var webView: WKWebView!
    fileprivate let kSSOReference = "code="
    
    public weak var delegate: SAWebViewControllerDelegate?
    
    public convenience init(withURL url: URL?){
        self.init(nibName: nil, bundle: nil)
        setUp()
        loadUrl(withUrl: url)
    }
    
    private func setUp() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        let leadingConstraint = NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        view.addConstraint(leadingConstraint)
        view.addConstraint(trailingConstraint)
        view.addConstraint(topConstraint)
        view.addConstraint(bottomConstraint)
    }
    
    private func loadUrl(withUrl url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: WKNavigationDelegate

extension SAWebViewController: WKNavigationDelegate, WKUIDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if url.absoluteString.contains(kSSOReference){
            decisionHandler(.cancel)
            
            if let components =  NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false),
                let queryItems = components.queryItems,
                let code = queryItems.first?.value {

                self.delegate?.finishAuthWithCode(withCode: code)
                
            } else {
                self.delegate?.finishAuthWithCode(withCode: nil)
            }
            
        } else {
            decisionHandler(.allow)
        }
    }
}
