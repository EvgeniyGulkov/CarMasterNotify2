//
//  LocalisedUILabel.swift
//  CarMasterNotify
//
//  Created by Admin on 10.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

class LocalizedLabel: UILabel {

    @IBInspectable var controllerName: String = "" {
        didSet {
            localize(controllerName)
        }
    }

    func localize(_ controllerName: String) {
        if let text = self.text {
            self.text = NSLocalizedString(text, tableName: controllerName, comment: "")
        }
    }
}
