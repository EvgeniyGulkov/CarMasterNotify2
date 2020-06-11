//
//  DefaultTextField.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

class DefaultTextField: UITextField {

    var hintLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.setPlaceHolderColor(color: UIColor.lightGray)
        self.textColor = Theme.Color.defaultTextColor
        setupHintLabel()
    }

    func setupHintLabel() {
        hintLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height-20, width: self.frame.width, height: 20))
        self.addSubview(hintLabel)
        hintLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        hintLabel.text = ""
        hintLabel.textColor = UIColor.red
        let font = hintLabel.font
        hintLabel.font = font?.withSize(10)
    }
}
