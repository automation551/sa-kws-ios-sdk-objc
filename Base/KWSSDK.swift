//
//  KWSSDK.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation

@objc public class KWSSDK : NSObject{
    
    static let _singletonInstance = KWSSDK()
    public override init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    // the sharedInstance class method can be reached from ObjC.
    public class func sharedInstance() -> KWSSDK {
        return KWSSDK._singletonInstance
    }
    
    // Some testing
    public func testKWSSDK() -> String {
        return "Hello KWSSDK"
    }
    
    public func getPotato() -> String {
        let potato = "potato"
        return potato
    }
    
    
}
