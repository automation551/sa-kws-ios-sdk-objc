//
//  UtilsBundleLoader.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 29/10/2018.
//


import Foundation

public class Bundle_Resource_Loader: NSObject {
    
    static func loadBundle() -> Bundle? {
        let podBundle = Bundle.init(for: Bundle_Resource_Loader.self)
        if let url = podBundle.url(forResource: "KWSiOSSDKObjC", withExtension: "bundle") {
            let bundle = Bundle.init(url: url)
            return bundle!
        }
        return nil
    }
    
    static public func loadImage(name: String?) -> UIImage? {
        
        guard let name = name, !name.isEmpty else { return nil }
        guard let bundle = loadBundle() else { return nil }
        return UIImage.init(named: name, in: bundle, compatibleWith: nil)
    }
    
    static public func loadLocalizedText(key: String) -> String? {
        
        guard let bundle = loadBundle() else { return nil }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}
