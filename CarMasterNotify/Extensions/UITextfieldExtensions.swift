//
//  UITextfieldExtensions.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

extension UITextField {
    func setPlaceHolderColor(color: UIColor) {
        guard let placeholder = placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
