//
//  SecureManager.swift
//  CarMasterNotify
//
//  Created by Gulkov on 09.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import KeychainAccess

class SecureManager {
    
    enum AccessLevel: String {
        case admin
        case master
        case client

        var string: String {
            switch self {
                // toDO need to add localized string
            case .admin:
                return "Admin"
            case .master:
                return "Master"
            case .client:
                return "Client"
            }
        }
    }
    private static let keychain = Keychain(service: Constants.SecureManager.service)

    static var accessLevel: AccessLevel {
        guard let user = User.currentUser, let accessLevel = user.accessLevel else {
            return .master
        }
        return AccessLevel(rawValue: accessLevel) ?? .master
    }

    static var accessToken: String {
        get {
            return (try? keychain.get(Constants.SecureManager.accessTokenKey)) ?? ""
        }
        set {
            try? keychain.accessibility(.afterFirstUnlock).set(newValue, key: Constants.SecureManager.accessTokenKey)
        }
    }

    static var refreshToken: String {
        get {
            return (try? keychain.get(Constants.SecureManager.refreshTokenKey)) ?? ""
        }
        set {
            try? keychain.accessibility(.afterFirstUnlock).set(newValue, key: Constants.SecureManager.refreshTokenKey)
        }
    }

    static var isAutorized: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.SecureManager.isAuthorizedKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.SecureManager.isAuthorizedKey)
        }
    }

    static func saveUserData(userdata: UserDataModel) {
        let user = User(context: DataController.shared.main)
        user.login = userdata.login
        user.nickName = userdata.login
        DataController.shared.save()
        if let accessToken = userdata.accessToken, let refreshToken = userdata.refreshToken {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            isAutorized = true
        }
    }

    static func SignOut() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        try? keychain.removeAll()
        isAutorized = false
        DataController.shared.removeAll()
        appDelegate.applicationCoordinator.start()
    }
}