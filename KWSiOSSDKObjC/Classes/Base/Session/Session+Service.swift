//
//  Session+Service.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import SAProtobufs
import SAMobileBase
import UIKit

internal struct SessionService: SessionServiceProtocol {
    
    
    // MARK: - Properties
    private let environment: NetworkEnvironmentProtocol
    private let storage: UserDefaults = UserDefaults.standard
    private let kTokenKey: String = "kwsSDK_LoggedUser_Token_key"
    
    // MARK: - Init
    init(environment: NetworkEnvironmentProtocol) {
        self.environment = environment
    }
    
    // MARK: - Methods

    func isUserLoggedIn() -> Bool {
        return getLoggedUser() != nil
    }

    func clearLoggedUser() -> Bool {
        let result = clearDb().take()
        return result ?? false
    }

    func getLoggedUser() -> LoggedUserModelProtocol? {

        let tokenRequest = ReadDbRequest(storage: storage, key: kTokenKey)
        let dbTask = ReadDbTask<String>()

        let base64Task = ParseBase64Task()
        let parseTask = ParseJsonTask<TokenData>()

        let result = dbTask.execute(input: tokenRequest)
        let tokenResult = result.then(base64Task.execute).then(parseTask.execute)

        switch result {
        case .success(let token):
            switch tokenResult {
            case .success(let tokenData):
                if let userId = tokenData.userId {
                    return LoggedUserModel(token: token, tokenData: tokenData , id: userId)
                } else {
                  return nil
                }
            case .error(_):
                return nil
            }
        case .error(_):
            return nil
        }
    }

    func saveLoggedUser(user: LoggedUserModelProtocol) -> Bool {

        let token = user.token
        let tokenRequest = WriteDbRequest(storage: storage, key: kTokenKey, value: token)
        let task = WriteDbTask()
        let tokenResult = task.execute(input: tokenRequest).take() ?? false

        return tokenResult
    }

    private func clearDb () -> Result<Bool> {
        let request = ClearDbRequest(storage: storage, key: kTokenKey)
        let task = ClearDbTask()
        return task.execute(input: request)
    }
}
