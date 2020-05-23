//
//  TwoButtonsTableViewCell.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TwoButtonsTableViewCell: BaseDarkTableViewCell {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
}
