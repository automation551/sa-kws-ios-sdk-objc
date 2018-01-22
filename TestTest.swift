//
//  TestTest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
public class TestTest {
    
    static let _singletonInstance = KWSSDK()
    public init() {
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
    
    public class func getPotato() -> String?{
        let potato = "potato"
        print(potato)
        return potato
    }
    
    
}
