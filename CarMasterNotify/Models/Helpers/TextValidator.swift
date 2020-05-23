//
//  TextValidator.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum ValidationType {
    case email
    case password
    case name
    case phone
    case confirmPassword(password: String?)
}

class TextValidator {

    static func checkContent(text: String, type: ValidationType) -> Bool {
        switch type {
        case .email:
            return true
        case .password:
            return true
        case .name:
            return true
        case .phone:
            return true
        case .confirmPassword:
            return true
        }
    }

    static func checkLength(text: String, type: ValidationType) -> Bool {
        switch type {
        case .email:
            return true
        case .password:
            return true
        case .name:
            return true
        case .phone:
            return true
        case .confirmPassword(let password):
            return true
        }
    }
}
