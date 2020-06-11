//
//  LocalisedUILabel.swift
//  CarMasterNotify
//
//  Created by Admin on 10.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

class LocalizedLabel: UILabel {

    @IBInspectable var localized: Bool = false {
        didSet {
            if localized {
                localize()
            }
        }
    }

    func localize() {
        if let text = self.text {
            self.text = NSLocalizedString(text, tableName: "Localization", comment: "")
        }
    }
}
