//
//  UtilsHelpers.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/02/2018.
//


import Foundation
import SAMobileBase


@objc public class UtilsHelpers : NSObject{
    
    static let _singletonInstance = UtilsHelpers()
    public override init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    // the sharedInstance class method can be reached from ObjC.
    public class func sharedInstance() -> UtilsHelpers {
        return UtilsHelpers._singletonInstance
        
    }
    
    
    public func getTokenData (token: String) -> TokenData? {
        
        let base64T = ParseBase64Task()
        let parseTask = ParseJsonTask<TokenData>()
        let resultToken = base64T.execute(input: token).then(parseTask.execute)
        
        switch resultToken {
        case .success(let tokenData):
            return tokenData
            break
        case .error(let error):
            return nil
            break
        }
        
    }
    
    public func getUserDetailsCountryCode(country: String) -> String?{
        
        /*
         .This is a helper mapping to the `country` from GET User Details, for the PUT in update user.
         - The GET User Details responds with country as full name (e.g "United Kingdom")
         - The PUT Update User Details needs to send a `lowercase country code` (!!!)
         */
        
        let countryCodeLower = localeForCountry(countryFullName: country)
        
        switch countryCodeLower {
        case "gb", "us", "it", "nl", "fr","be":
            return countryCodeLower
        default:
            return ""
        }
        
    }
    
    private func localeForCountry(countryFullName : String) -> String {
        var locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if countryFullName.lowercased() == countryName?.lowercased() {
                return localeCode.lowercased() as! String
            }
        }
        return locales
    }
    
}

