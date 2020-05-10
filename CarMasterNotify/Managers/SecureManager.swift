//
//  SecureManager.swift
//  CarMasterNotify
//
//  Created by Gulkov on 09.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

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

    static var accessLevel: AccessLevel {
        guard let user = User.currentUser, let accessLevel = user.accessLevel else {
            return .master
        }
        return AccessLevel(rawValue: accessLevel) ?? .master
    }
}
