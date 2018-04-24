//
//  TableViewController.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 29/03/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import UIKit
import KWSiOSSDKObjC
import SAProtobufs
import SAMobileBase

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var kUserNetworkEnvironment : ComplianceNetworkEnvironment?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    //strong reference to our Service Protocol
    private var singleSignOn: SingleSignOnServiceProtocol?

    private let rowHeight: CGFloat = 44.0
    private let headerHeight: CGFloat = 50.0
    
    private let kNoUserCachedText = "\nNo valid user cached!!!\n"

    //dictionary of KEY String and VALUE list of Strings - no order specified
    let functionalitiesDict: [ String : [String] ] =
        [
            "Permissions" :
                ["Submit Parent Email", "Request Permissions"],
            "User" :
                ["Random Username", "Create User", "Login User", "Update User", "Get User Details", "Auth User", "Logout"],
            "App Data" :
                ["Get App Data", "Set App Data"],
            "Invite" :
                ["Invite User"],
            "Events" :
                ["Trigger Event", "Is Triggered Event"],
            "Score" :
                ["Get Leaderboard", "Get User Score"]
    ]
    
    
    // MARK: - TABLE VIEW STUFF
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let section = Array(functionalitiesDict)[indexPath.section].key
        let arrayOfRows = Array(functionalitiesDict)[indexPath.section].value

        switch section {
        case "User":
            switch arrayOfRows[indexPath.row] {
            case "Login User" : self.loginUser()
            case "Create User" : self.createUser()
            case "Random Username": self.randomUserName()
            case "Update User": self.updateUserDetails()
            case "Get User Details": self.getUserDetails()
            case "Auth User": self.oAuthUser()
            case "Logout": self.logoutUser()
            default:
                break
            }
            break
        case "Permissions":
            switch arrayOfRows[indexPath.row] {
            case "Submit Parent Email" : self.updateParentEmail()
            case "Request Permissions" : self.requestPermissions()
            default:
                break
            }
        case "App Data":
            switch arrayOfRows[indexPath.row] {
            case "Get App Data": self.getAppData()
            case "Set App Data" : self.setAppData()
            default:
                break
            }
        case "Invite":
            switch arrayOfRows[indexPath.row] {
            case "Invite User": self.inviteUser()
            default:
                break
            }
        case "Events":
            switch arrayOfRows[indexPath.row] {
            case "Trigger Event": self.triggerEvent()
            case "Is Triggered Event": self.isTriggeredEvent()
            default:
                break
            }
        case "Score":
            switch arrayOfRows[indexPath.row] {
            case "Get Leaderboard": self.getLeaderboard()
            case "Get User Score": self.getUserScore()
            default:
                break
            }
        default:
            break
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        let listOfItemsInRow = Array(functionalitiesDict)[indexPath.section].value
        let textForRow = Array(listOfItemsInRow)[indexPath.row]

        cell.textLabel?.text = textForRow

        return cell
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let textForSection = Array(functionalitiesDict)[section].key
        return textForSection
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return functionalitiesDict.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = Array(functionalitiesDict)[section].value
        return items.count
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    //END OF TABLE VIEW STUFF ----------------------------------------------------------------------//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        kUserNetworkEnvironment = DemoTestEnvironment()
        self.textView.text! = "Here will be the responses: \n"
    }
    
    func updateTextView(text: String){
        self.textView.text! += text
        
        let bottom = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(bottom)
    }
    
    func createUser(){

        let userName = String (format: "randomtestusr%d", randomInt(min:100, max:500))
        let pwd = "testtest"
        let dob = "2012-03-22"
        let country = "US"
        let parentEmail = "mobile.dev.test@superawesome.tv"

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let auth = sdk.getService(withType: AuthServiceProtocol.self)

        auth?.createUser(username: userName, password: pwd, timeZone: nil, dateOfBirth: dob, country: country, parentEmail: parentEmail) { (result, error) in

            var responseText: String = ""
            
            if let user = result {
                self.saveUser(user: user)
                responseText = "\nResult for create user with username '\(userName)' and pwd '\(pwd)' is success! User ID is - \(user.id) and has been cached.\n"
            } else {
                if let errorMessage : String = (error as! ErrorWrapper).message {
                    responseText = "\nSomething went wrong for create user: '\(errorMessage)'\n"
                } else {
                    responseText = "\nSomething went wrong for create user: unknown error!\n"
                }
            }
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func loginUser(){

        let userName = "randomtestuser123"
        let pwd = "testtest"
        
        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let auth = sdk.getService(withType: AuthServiceProtocol.self)

        auth?.loginUser(userName: userName, password: pwd) { (result, error) in

            var responseText: String = ""
            
            if let user = result {
                self.saveUser(user: user)
                if let userCached = self.getLoggedUser(){
                    responseText = "\nThe login result is success: User ID is \(userCached.id as? Int ?? 0)\n"
                } else {
                    responseText = "\nThe login result is success but something went bad caching it...\n"
                }
            } else {
                if let errorMessage : String = (error as! ErrorWrapper).error {
                    responseText = "\nSomething went wrong for login: '\(errorMessage)'\n"
                } else {
                    responseText = "\nSomething went wrong for login: unknown error!\n"
                }
            }
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func randomUserName(){
        
        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let username = sdk.getService(withType: UsernameServiceProtocol.self)

        username?.getRandomUsername() { (result, error) in
            
            var responseText: String = ""
            
            if error == nil {
                responseText = "\nThe random name result is ---> \(result?.randomUsername ?? "ERROR")\n"
            } else {
                if let errorMessage : String = (error as! ErrorWrapper).codeMeaning {
                    responseText = "\nSomething went wrong for random username: '\(errorMessage)'\n"
                } else {
                     responseText = "\nSomething went wrong for random username: unknown error!\n"
                }
            }
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func requestPermissions(){

        let permissions : [String] = ["accessEmail","accessAddress"]

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let userActions = sdk.getService(withType: UserActionsServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let userId : Int = cachedUser.id as? Int ?? 0
            userActions?.requestPermissions(permissions: permissions, userId: userId, token: cachedUser.token) { error in

                if error == nil {
                    responseText = "\nThe following permissions were requested with success: \n"
                } else {
                     if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for request permissions: '\(errorMessage)'\n"
                     } else {
                        responseText = "\n Unknown error for permissions:!\n"
                    }
                }
                
                //iterate over list to append to text display
                for perm in permissions{
                    responseText += perm + "\n"
                }
                
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func updateParentEmail(){

        let parentEmail = "mobile.dev.test@superawesome.tv"

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let user = sdk.getService(withType: UserServiceProtocol.self)

        let map: [String : Any] = ["parentEmail" : parentEmail]
        
        var responseText: String = ""

        if let cachedUser = getLoggedUser(){

            let userId = cachedUser.id as? Int ?? 0
            
            user?.updateUser(details: map, userId: userId , token: cachedUser.token) { (error) in

                if error == nil {
                    responseText = "\nUser parent email updated with email: \(parentEmail) \n"
                } else {
                     if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for update details: '\(errorMessage)' \n"
                     } else {
                        responseText = "\nSomething went wrong for update details: unknown error!\n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func updateUserDetails(){

        //check documentation to see what fields can be updated

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let user = sdk.getService(withType: UserServiceProtocol.self)

        let map: [String : Any] = ["firstName" : "John",
                                   "lastName" : "Doy",
                                   "address" : ["street": "Number One",
                                                "city": "London",
                                                "postCode": "abc",
                                                "country": "GB"
            ]
        ]

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser(){

            let userId = cachedUser.id as? Int ?? 0

            user?.updateUser(details: map, userId: userId, token: cachedUser.token) { (error) in

                if error == nil {
                    responseText = "\nUser details updated!\n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for update details: '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for update details: '\(error)' \n"
                    } else {
                        responseText = "\nSomething went wrong for update details: unknown error!\n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func getUserDetails() {

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let user = sdk.getService(withType: UserServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser(){

            let userId : Int = cachedUser.id as? Int ?? 0
            user?.getUser(userId: userId, token: cachedUser.token) { userDetails, error in

                if userDetails != nil {
                    responseText = "\nGET user details is success. User id is: \(userDetails?.id as? Int ?? 0)\n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).codeMeaning {
                        responseText = "\nSomething went wrong for GET details: '\(errorMessage)' \n"
                    } else {
                        responseText = "\nSomething went wrong for GET details: unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func getAppData(){

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let userActions = sdk.getService(withType: UserActionsServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            userActions?.getAppData(userId: userId, appId: appId, token: token) { appData, error in

                if appData != nil {
                    
                    if let results = appData?.results{
                        
                        responseText = "\nGot app data with '\(appData?.count ?? 0)' items:\n"
                        
                        //iterate over list to append to text display
                        for (index, items) in results.enumerated() {
                            responseText += "- Name #\(index + 1) is '\(items.name ?? "")' and Value is '\(items.value as? Int ?? 0)'\n"
                        }
                    } else {
                        responseText = "\nGot app data, but no items seems to be available..."
                    }
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for GET app data: '\(errorMessage)' \n"
                    } else {
                        responseText = "\nSomething went wrong for GET app data: unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func setAppData(){

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let userActions = sdk.getService(withType: UserActionsServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            let value = 123
            let key = "new_value"

            userActions?.setAppData(value: value, key: key, userId: userId, appId: appId, token: token) { error in

                if error == nil {
                    responseText = "\nApp Data set with success. Value was set as '\(value)' and Key for as '\(key)' \n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for set app data with Value as '\(value)' and Key as '\(key)': '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for set app data with Value as '\(value)' and Key as '\(key)': '\(error)' \n"
                    } else{
                        responseText = "\nSomething went wrong for set app data with Value as '\(value)' and Key as '\(key)': unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }

        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func inviteUser(){

        let emailAddress = "mobile.dev.test+1@superawesome.tv"

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let userActions = sdk.getService(withType: UserActionsServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let token = cachedUser.token

            userActions?.inviteUser(email: emailAddress, userId: userId, token: token) { error in

                if error == nil {
                    responseText = "\nInvited User '\(emailAddress)' with success. \n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for invite user: '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for invite user: '\(error)' \n"
                    } else{
                        responseText = "\nSomething went wrong for invite user: unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func triggerEvent(){

        let eventId = "8X9QneMSaxU2VzCBJI5YdxRGG7l3GOUw"
        let points = 20

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let userActions = sdk.getService(withType: UserActionsServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let token = cachedUser.token

            userActions?.triggerEvent(eventId: eventId, points: points, userId: userId, token: token ){ error in

                if error == nil {
                    responseText = "\nTrigger Event with SUCCESS. Token requested was '\(eventId)' and Points were '\(points)' \n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for trigger event with Token as '\(eventId)' and Points value '\(points)':\n- '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for trigger event with Token as '\(eventId)' and Points value '\(points)':\n- '\(error)' \n"
                    } else{
                        responseText = "\nSomething went wrong for trigger event with Token as '\(eventId)' and Points value '\(points)':'n- unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func isTriggeredEvent(){

        let eventId = 802
        
        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let userActions = sdk.getService(withType: UserActionsServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let token = cachedUser.token
            userActions?.hasTriggeredEvent(eventId: eventId, userId: userId, token: token){ (hasTriggeredEvent, error) in

                if hasTriggeredEvent != nil {
                    responseText = "\nHas Triggered Event with success for EventID as '\(eventId)' \n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for has triggered event id '\(eventId)':\n- '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for has triggered event id '\(eventId)':\n- '\(error)' \n"
                    } else{
                        responseText = "\nSomething went wrong for has triggered event id '\(eventId)':\n- unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }

    func getLeaderboard(){

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let score = sdk.getService(withType: ScoreServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            score?.getLeaderboard(appId: appId, token: token ){ (response, error) in

                if response != nil {
                    
                    if let results = response?.results {
                    
                    responseText = "\nGot Leaderboard data with '\(response?.count ?? 0)' items:\n"
                    
                    //iterate over list to append to text display
                    for (index, items) in results.enumerated() {
                        responseText += "- Name #\(index + 1) is '\(items.name ?? "")', Rank is '\(items.rank )' and Score is '\(items.score)'\n"
                    }
                } else {
                    responseText = "\nGot Leaderboard data, but no items seems to be available..."
                }
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for GET Leaderboard data: '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for GET Leaderboard data: '\(error)' \n"
                    } else{
                        responseText = "\nSomething went wrong for GET Leaderboard data: unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
        
    }

    func getUserScore(){

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let score = sdk.getService(withType: ScoreServiceProtocol.self)

        var responseText: String = ""
        
        if let cachedUser = getLoggedUser() {

            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            score?.getScore(appId: appId, token: token){ (response, error) in

                if response != nil {
                    responseText = "\nGet Score with success. Score is '\(response?.score ?? 0)' and Rank is \(response?.rank ?? 0)\n"
                } else {
                    if let errorMessage : String = (error as! ErrorWrapper).message {
                        responseText = "\nSomething went wrong for GET user score: '\(errorMessage)' \n"
                    } else if let error : String = (error as! ErrorWrapper).error {
                        responseText = "\nSomething went wrong for GET user score: '\(error)' \n"
                    } else{
                        responseText = "\nSomething went wrong for GET user score: unknown error \n"
                    }
                }
                //update text
                self.updateTextView(text: responseText)
            }
        } else {
            responseText = kNoUserCachedText
            //update text
            self.updateTextView(text: responseText)
        }
    }
    
    func oAuthUser() {
        
        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        singleSignOn = sdk.getService(withType: SingleSignOnServiceProtocol.self)
        
        let urlString = (kUserNetworkEnvironment as! DemoTestEnvironment).singleSignOn
        
        var responseText: String = ""
        
        singleSignOn?.signOn(url: urlString, parent: self) { (response, error) in
             
            if let user = response {
                self.saveUser(user: user)
                if let userCached = self.getLoggedUser(){
                    responseText = "\nThe OAuth result is success: User ID is \(userCached.id as? Int ?? 0)\n"
                } else {
                    responseText = "\nThe OAuth result is success but something went bad caching it...\n"
                }
            } else {
                if let errorMessage : String = (error as! ErrorWrapper).message {
                    responseText = "\nSomething went wrong for GET user score: '\(errorMessage)' \n"
                } else if let error : String = (error as! ErrorWrapper).error {
                    responseText = "\nSomething went wrong for GET user score: '\(error)' \n"
                } else{
                    responseText = "\nSomething went wrong for GET user score: unknown error \n"
                }
            }
            //update text
            self.updateTextView(text: responseText)
            
            //clear reference to Single Sign On Service
            self.singleSignOn = nil
        }
    }

    func logoutUser(){
        
        var responseText: String = ""
        
        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        if let sessionsService = sdk.getService(withType: SessionServiceProtocol.self), sessionsService.clearLoggedUser() {
            responseText = "\nUser cleared!!!\n"
        } else {
            responseText = "\nOops...something went wrong clearing the user...\n"
        }
        
        //update text
        self.updateTextView(text: responseText)
    }
    
    func saveUser(user: LoggedUserModelProtocol) {
        
        var responseText: String = ""

        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        if let sessionsService = sdk.getService(withType: SessionServiceProtocol.self), sessionsService.saveLoggedUser(user: user) {
            responseText = "\nUser saved successfully!!!"
        } else {
            responseText = "\nOops...something went wrong saving the user...\n"
        }
        
        //update text
        self.updateTextView(text: responseText)
    }

    func getLoggedUser() -> LoggedUserModel? {
        let sdk = ComplianceSDK(withEnvirnoment: kUserNetworkEnvironment!)
        let sessionsService = sdk.getService(withType: SessionServiceProtocol.self)
        if let user = sessionsService?.getLoggedUser() as? LoggedUserModel {
            return user
        } else {
            return nil
        }
    }
    

    // MARK - helper methods -----------------------------------

    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    // end of helper methods -----------------------------------
}
