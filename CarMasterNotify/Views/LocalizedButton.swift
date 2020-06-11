//
//  LocalizedButton.swift
//  CarMasterNotify
//
//  Created by Admin on 10.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

class LocalizedButton: UIButton {

    @IBInspectable var localized: Bool = false {
        didSet {
            if localized {
                localize()
            }
        }
    }

    func localize() {
        if let text = self.titleLabel?.text {
            let title = NSLocalizedString(text, tableName: "Localization", comment: "")
            setTitle(title, for: [])
        }
    }
}
