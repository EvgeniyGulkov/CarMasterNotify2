//
//  StringExtensions.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

extension String {
    func validate(type: ValidationType) -> String {
        guard !isEmpty else {return " "}
        var result = TextValidator.checkContent(text: self, type: type)
        if !result {
            return type.contentError
        } else {
            result = TextValidator.checkLength(text: self, type: type)
            if !result {
                return type.lengthError
            } else {
                return ""
            }
        }
    }
}
