//
//  DefaultTextLabel.swift
//  CarMasterNotify
//
//  Created by Gulkov on 09.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DefaultTextLabel: UILabel {

    @IBInspectable var txtColor: UIColor = Theme.Color.defaultTextColor {
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
