//
//  ButtonTableViewCell.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

class ButtonTableViewCell: BaseDarkTableViewCell {
    @IBOutlet weak var button: RoundedCornerButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
}
