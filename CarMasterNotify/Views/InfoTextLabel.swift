//
//  InfoLabel.swift
//  CarMasterNotify
//
//  Created by Admin on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class InfoTextLabel: UILabel {
    @IBInspectable var txtColor: UIColor = Theme.Color.tIntColor {
        didSet {
            self.textColor = txtColor
        }
    }

    func setup() {
       self.textColor = txtColor
    }

    override func awakeFromNib() {
        setup()
    }

    override func prepareForInterfaceBuilder() {
        setup()
    }
}
