//
//  TextValidator.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum ValidationType {
    case email
    case password
    case name
    case phone
    case confirmPassword(password: String?)

    var lengthError: String {
        switch self {
        case .name:
            return L10n.nameLength
        case .phone:
            return L10n.phoneLength
        case .email:
            return L10n.emailContent
        case .password:
            return L10n.passwordLength
        default: return ""
        }
    }

    var contentError: String {
        switch self {
        case .name:
            return L10n.nameContent
        case .phone:
            return L10n.phoneContent
        case .email:
            return L10n.emailContent
        case .password:
            return L10n.passwordLength
        case .confirmPassword:
            return L10n.confirmPasswordContent
        }
    }

}

class TextValidator {

    static func checkContent(text: String, type: ValidationType) -> Bool {
        switch type {
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: text)
        case .password:
            let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&?]{8,16}$"
            let passPred = NSPredicate(format: "SELF MATCHES %@", passRegEx)
            return passPred.evaluate(with: text)
        case .name:
            let nameRegEx = "^[a-zA-Z0-9]+$"
            let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
            return namePred.evaluate(with: text)
        case .phone:
            let phoneRegEx = "^[0-9]+$"
            let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            return phonePred.evaluate(with: text)
        case .confirmPassword(let password):
            return text == password
        }
    }

    static func checkLength(text: String, type: ValidationType) -> Bool {
        switch type {
        case .name:
            return text.count > 1 && text.count < 20
        case .phone:
            return text.count > 7 && text.count < 15
        default:
            return true
        }
    }
}
