//
//  CarMasterError.swift
//  CarMasterNotify
//
//  Created by Gulkov on 10.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum CarMasterError: String, Error, LocalizedError {
    case userNotFound
    case userExist
    
    public var errorDescription: String? {
        return localizedString(error: self)
    }

    private func localizedString(error: CarMasterError) -> String {
        let key = error.rawValue
        return NSLocalizedString(key, tableName: "CarMasterError", comment: "")
    }
}
