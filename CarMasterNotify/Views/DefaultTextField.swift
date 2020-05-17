//
//  DefaultTextField.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DefaultTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.textColor = Theme.Color.defaultTextColor
    }
}
