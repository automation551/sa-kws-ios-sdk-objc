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
        
        let webViewController = SAWebViewController(withURL: authURL)
        webViewController.delegate = self
        let navController = UINavigationController.init(rootViewController: webViewController)
        parentRef.present(navController, animated: true, completion: nil)
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
    fileprivate var kNeedsBackButtonCounter = 0
    public weak var delegate: SAWebViewControllerDelegate?
    
    public convenience init(withURL url: URL?){
        self.init(nibName: nil, bundle: nil)
        setUpWebView()
        loadUrl(withUrl: url)
    }
    
    fileprivate func setUpNavController(counter: Int){
        resetNavigationbar()
        addCloseButtonToNavBar()
        if counter > 0 {
            addBackButtonToNavBar()
        }
    }
    
    fileprivate func addCloseButtonToNavBar(){
        var rightItems: [UIBarButtonItem] = navigationItem.rightBarButtonItems ?? []
        let rightBackBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeView))
        if !rightItems.contains(rightBackBarButton) {
            rightItems.append(rightBackBarButton)
            navigationItem.setRightBarButtonItems(rightItems, animated: true)
        }
    }
    
    fileprivate func addBackButtonToNavBar(){
        var leftItems: [UIBarButtonItem] = navigationItem.leftBarButtonItems ?? []
        let leftBackImage = Bundle_Resource_Loader.loadImage(name: "back_button_icon")
        let leftBarButton = UIBarButtonItem(image: leftBackImage, style: .done, target: self, action: #selector(goBack))
        if let wb = webView {
            if !leftItems.contains(leftBarButton) && wb.canGoBack {
                leftItems.append(leftBarButton)
                navigationItem.setLeftBarButtonItems(leftItems, animated: true)
            }
        }
    }
    
    private func resetNavigationbar(){
        navigationItem.setLeftBarButtonItems([], animated: false)
        navigationItem.setRightBarButtonItems([], animated: false)
    }
    
    @objc
    private func goBack() {
        webView?.goBack()
        if kNeedsBackButtonCounter > 0 {
            kNeedsBackButtonCounter = kNeedsBackButtonCounter - 1
        } else {
            kNeedsBackButtonCounter = 0
        }
    }
    
    private func setUpWebView() {
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
    
    @objc
    private func closeView() {
        self.dismiss(animated: true, completion: nil)
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
        } else if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            decisionHandler(.allow)
            kNeedsBackButtonCounter = kNeedsBackButtonCounter + 1
        }  else {
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setUpNavController(counter: kNeedsBackButtonCounter)
    }
}
