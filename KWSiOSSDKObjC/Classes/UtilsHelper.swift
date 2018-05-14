//
//  UtilsHelper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/05/2018.
//
import SAMobileBase

public class UtilsHelper : NSObject{
    
    static let _singletonInstance = UtilsHelper()
    
    public override init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    static public func getMetadataFromToken(token : String) -> TokenData?{
        
        let base64Task = ParseBase64Task()
        let parseTask = ParseJsonTask<TokenData>()
        
        let tokenResult = base64Task.execute(input: token).then(parseTask.execute)
        
        return tokenResult.take()
    }
    
}



