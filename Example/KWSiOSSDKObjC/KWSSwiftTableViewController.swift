//
//  KWSSwiftTableViewController.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 29/03/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import UIKit
import KWSiOSSDKObjC
import SAProtobufs
import SAMobileBase

class KWSSwiftTableViewController: UITableViewController {

    var kUserKWSNetworkEnvironment : KWSNetworkEnvironment?

    private let rowHeight: CGFloat = 44.0
    private let headerHeight: CGFloat = 50.0

    //dictionary of KEY String and VALUE list of Strings - no order specified
    let functionalitiesDict: [ String : [String] ] =
        [
            "Permissions" :
                ["Submit Parent Email", "Request Permissions"],
            "User" :
                ["Random Username", "Create User", "Login User", "Update User", "Get User Details"],
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
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let textForSection = Array(functionalitiesDict)[section].key
        return textForSection
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

        cell.textLabel?.text = textForRow

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
    //END OF TABLE VIEW STUFF ----------------------------------------------------------------------//

    override func viewDidLoad() {
        super.viewDidLoad()

        kUserKWSNetworkEnvironment = DemoTestEnvironment()
    }

    func createUser(){

        let userName = String (format: "randomtestusr%d", randomInt(min:100, max:500))
        let pwd = "testtest"
        let dob = "2012-03-22"
        let country = "US"
        let parentEmail = "mobile.dev.test@superawesome.tv"

        let auth = KWSSDK.getService(value: AuthServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        auth?.createUser(username: userName, password: pwd, timeZone: nil, dateOfBirth: dob, country: country, parentEmail: parentEmail) { (result, error) in

            if let user = result {
                self.saveUser(user: user)
                print("Result for create user is success: \(String(describing: user))")
            } else {
                print("Something went wrong for create user: \(String(describing: error)))")
            }
        }
    }

    func loginUser(){

        let userName = "randomtestuser123"
        let pwd = "testtest"

        let auth = KWSSDK.getService(value: AuthServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        auth?.loginUser(userName: userName, password: pwd) { (result, error) in

            if let user = result {
                self.saveUser(user: user)
                print("Result for login is success: \(String(describing: user))")
            } else {
                print("Something went wrong for login \(String(describing: error)))")
            }
        }
    }

    func randomUserName(){

        let username = KWSSDK.getService(value: UsernameServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        username?.getRandomUsername() { (result, error) in

            if(error == nil){
                print("Result for random username is success: \(String(describing: result?.randomUsername))")
            } else {
                print("Something went wrong for random username: \(String(describing: error)))")
            }
        }
    }

    func requestPermissions(){

        let permissions : [String] = ["accessEmail","accessAddress"]

        let userActions = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let userId : Int = cachedUser.id as? Int ?? 0
            userActions?.requestPermissions(permissions: permissions, userId: userId, token: cachedUser.token) { error in

                if error == nil {
                    print("Permissions requested with success!")
                } else {
                    print("Something went wrong for request permissions: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func updateParentEmail(){


        let parentEmail = "mobile.dev.test@superawesome.tv"

        let user = KWSSDK.getService(value: UserServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        let map: [String : Any] = ["parentEmail" : parentEmail]

        if let cachedUser = getLoggedUser(){

            let userId = cachedUser.id as? Int ?? 0
            user?.updateUser(details: map, userId: userId , token: cachedUser.token) { (error) in

                if error == nil {
                    print("User updated!")
                } else {
                    print("Something went wrong for update user: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func updateUserDetails(){

        //check documentation to see what fields can be updated

        let user = KWSSDK.getService(value: UserServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        let map: [String : Any] = ["firstName" : "John",
                                   "lastName" : "Doy",
                                   "address" : ["street": "Number One",
                                                "city": "London",
                                                "postCode": "abc",
                                                "country": "GB"
            ]
        ]

        if let cachedUser = getLoggedUser(){

            let userId = cachedUser.id as? Int ?? 0

            user?.updateUser(details: map, userId: userId, token: cachedUser.token) { (error) in

                if error == nil {
                    print("User updated!")
                } else {
                    print("Something went wrong for update user: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func getUserDetails() {

        let user = KWSSDK.getService(value: UserServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser(){

            let userId : Int = cachedUser.id as? Int ?? 0
            user?.getUser(userId: userId, token: cachedUser.token) { userDetails, error in

                if userDetails != nil {
                    print("Got user: \(String(describing: userDetails))")
                } else {
                    print("Something went wrong for get user details: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func getAppData(){

        let userActions = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            userActions?.getAppData(userId: userId, appId: appId, token: token) { appData, error in

                if appData != nil {
                    print("Got app data: \(String(describing: appData))")
                } else {
                    print("Something went wrong for get user details: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func setAppData(){

        let userActions = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            let value = 123
            let key = "new_value"

            userActions?.setAppData(value: value, key: key, userId: userId, appId: appId, token: token) { error in

                if error == nil {
                    print("App Data set with success!")
                } else {
                    print("Something went wrong for App Data: \(String(describing: error))")
                }
            }

        } else {
            print("No valid user cached!!!")
        }
    }

    func inviteUser(){

        let emailAddress = "mobile.dev.test+1@superawesome.tv"

        let userActions = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let token = cachedUser.token

            userActions?.inviteUser(email: emailAddress, userId: userId, token: token) { error in

                if error == nil {
                    print("Invited User with success!")
                } else {
                    print("Something went wrong for Invite User: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func triggerEvent(){

        let eventId = "8X9QneMSaxU2VzCBJI5YdxRGG7l3GOUw"
        let points = 20

        let userActions = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let token = cachedUser.token

            userActions?.triggerEvent(eventId: eventId, points: points, userId: userId, token: token ){ error in

                if error == nil {
                    print("Trigger Event with success!")
                } else {
                    print("Something went wrong for Trigger Event: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func isTriggeredEvent(){

        let eventId = 802
        let userActions = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let userId = cachedUser.id as? Int ?? 0
            let token = cachedUser.token
            userActions?.hasTriggeredEvent(eventId: eventId, userId: userId, token: token){ (hasTriggeredEvent, error) in

                if hasTriggeredEvent != nil {
                    print("Has Triggered Event with success!")
                } else {
                    print("Something went wrong for Has Triggered Event: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func getLeaderboard(){

        let score = KWSSDK.getService(value: ScoringServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            score?.getLeaderboard(appId: appId, token: token ){ (response, error) in

                if (response != nil){
                    print("Get Leaderboard with success: \(String(describing: response))")
                } else {
                    print("Something went wrong for Get Leaderboard: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func getUserScore(){

        let score = KWSSDK.getService(value: ScoringServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)

        if let cachedUser = getLoggedUser() {

            let appId = cachedUser.tokenData.appId
            let token = cachedUser.token

            score?.getScore(appId: appId, token: token){ (response, error) in

                if (response != nil){
                    print("Get Score with success: \(String(describing: response))")
                } else {
                    print("Something went wrong for Get Score: \(String(describing: error))")
                }
            }
        } else {
            print("No valid user cached!!!")
        }
    }

    func saveUser(user: LoggedUserModelProtocol) {
        let sessionsService = KWSSDK.getService(value: SessionServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)
        let success = sessionsService?.saveLoggedUser(user: user)
    }

    func getLoggedUser() -> LoggedUser? {
        let sessionsService = KWSSDK.getService(value: SessionServiceProtocol.self, environment: kUserKWSNetworkEnvironment!)
        if let user = sessionsService?.getLoggedUser() as? LoggedUser {
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
