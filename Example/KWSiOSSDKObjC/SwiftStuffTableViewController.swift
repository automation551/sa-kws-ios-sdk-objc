//
//  SwiftStuffTableViewController.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 29/03/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import UIKit
import KWSiOSSDKObjC
import SAProtobufs

class SwiftStuffTableViewController: UITableViewController {
    
    //for Environment
    let API = "https://kwsapi.demo.superawesome.tv/"
    let SINGLE_SIGN_ON = "https://club.demo.superawesome.tv/"
    let CLIENT_ID  = "kws-sdk-testing"
    let CLIENT_SECRET = "TKZpmBq3wWjSuYHN27Id0hjzN4cIL13D"
    
    var kUserKWSNetworkEnvironment : KWSNetworkEnvironment?
    
    
    //dictionary of KEY String and VALUE list of Strings - no order specified
    let functionalitiesDict: [ String : [String] ] =
        [
            "Permissions" : ["Request Permissions"],
            "User" : ["LoginUser","Create User","Random Username"]
    ]
    
    
    
    // MARK: - TABLE VIEW STUFF
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let textForSection = Array(functionalitiesDict)[section].key
        
        return "\(textForSection)"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return functionalitiesDict.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let items = Array(functionalitiesDict)[section].value
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let listOfItemsInRow = Array(functionalitiesDict)[indexPath.section].value
        let textForRow = Array(listOfItemsInRow)[indexPath.row]
        
        cell.textLabel?.text = "\(textForRow)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = Array(functionalitiesDict)[indexPath.section].key
        let arrayOfRows = Array(functionalitiesDict)[indexPath.section].value
        
        switch section {
        case "User":
            switch arrayOfRows[indexPath.row] {
            case "LoginUser" : self.loginUser()
            case "Create User" : self.createUser()
            case "Random Username": self.randomUserName()
            default:
                break
            }
            break
        case "Permissions":
            switch arrayOfRows[indexPath.row] {
            case "Request Permissions" : self.requestPermissions()
            default:
                break
                
            }
        default:
            break
        }
        
    }
    
    //END OF TABLE VIEW STUFF ----------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kUserKWSNetworkEnvironment = UserKWSNetworkEnvironment(domain: API, appID: CLIENT_SECRET, mobileKey: CLIENT_ID)
        
    }
    
    func loginUser(){
        
        let userName = "guitestnumber3"
        let pwd = "testtest"
        
        let auth = KWSSDK.getService(value: AuthServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)
        
        auth?.loginUser(userName: userName, password: pwd) { (result, error) in
            
            if(error == nil){
                print("Result for login is success")
            } else {
                print("Something went wrong for login \(String(describing: error)))")
            }
            
        }
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func createUser(){
        
        let userName = String (format: "guitestusr%d", randomInt(min:100, max:500))
        let pwd = "testtest"
        let dob = "2012-03-22"
        let country = "US"
        let parentEmail = "guilherme.mota@superawesome.tv"
        
        let auth = KWSSDK.getService(value: AuthServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)
        
        auth?.createUser(username: userName, password: pwd, timeZone: nil, dateOfBirth: dob, country: country, parentEmail: parentEmail) { (result, error) in
            
            if(error == nil){
                print("Result for create user is success: \(String(describing: result))")
            } else {
                print("Something went wrong for create user \(String(describing: error)))")
            }
            
        }
        
    }
    
    func randomUserName(){
        
        let username = KWSSDK.getService(value: UsernameServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)
        
        username?.getRandomUsername() { (result, error) in
            
            if(error == nil){
                print("Result for random username is success: \(String(describing: result?.randomUsername))")
            } else {
                print("Something went wrong for random username \(String(describing: error)))")
            }
        }
        
        
    }
    
    func requestPermissions(){
        
        //todo
        
    }
    
}
