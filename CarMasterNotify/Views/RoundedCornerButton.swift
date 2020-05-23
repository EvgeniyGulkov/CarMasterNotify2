//
//  RoundedCornerButton.swift
//  CarMasterNotify
//
//  Created by Admin on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RoundedCornerButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15.0
        backgroundColor = Theme.Color.blueColor
        setTitleColor(Theme.Color.defaultTextColor, for:[])
        setEnabled(isEnabled: isEnabled)
    }

    func setEnabled(isEnabled: Bool) {
        self.isEnabled = isEnabled
        if isEnabled {
            backgroundColor = Theme.Color.blueColor
        } else {
            backgroundColor = Theme.Color.disabledButtonColor
        }
    }
}
