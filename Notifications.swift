//
//  Notifications.swift
//  PopJamUI
//
//  Created by Myles Eynon on 10/04/2018.
//

import UIKit

public struct Notifications {
    
    enum NotificationIdentifier: String {
        case item = "tv.superawesome.kws"
        
        var notificationName: NSNotification.Name {
            return NSNotification.Name(self.rawValue)
        }
    }
    
    static func addObserver(withObserver observer: Any, handler: Selector, notificationIdentifier: NotificationIdentifier) {
        NotificationCenter.default.addObserver(observer, selector: handler, name: notificationIdentifier.notificationName, object: nil)
    }
    
    static func removeObserver(withObserver observer: Any, notificationIdentifier: NotificationIdentifier) {
        NotificationCenter.default.removeObserver(observer, name: notificationIdentifier.notificationName, object: nil)
    }
    
    static func postNotification(withNotificationIdentifier notificationIdentifier: NotificationIdentifier, userInfo: [String: Any]?) {
        NotificationCenter.default.post(name: notificationIdentifier.notificationName, object: nil, userInfo: userInfo)
    }
    
    static func addKeyboardNotifications(withObserver observer: Any, willShowHandler: Selector,
                                   willHideHandler: Selector,
                                   didShowHandler: Selector? = nil,
                                   didHideHandler: Selector? = nil) {
        
        NotificationCenter.default.addObserver(observer, selector: willShowHandler, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(observer, selector: willHideHandler, name: .UIKeyboardWillHide, object: nil)
        
        if let didShowHandler = didShowHandler {
            NotificationCenter.default.addObserver(observer, selector: didShowHandler, name: .UIKeyboardDidShow, object: nil)
        }
        
        if let didHideHandler = didHideHandler {
            NotificationCenter.default.addObserver(observer, selector: didHideHandler, name: .UIKeyboardDidHide, object: nil)
        }
    }
    
    static func removeKeyboardNotifications(withObserver observer: Any) {
        NotificationCenter.default.removeObserver(observer, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(observer, name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(observer, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(observer, name: .UIKeyboardDidHide, object: nil)
    }
}
