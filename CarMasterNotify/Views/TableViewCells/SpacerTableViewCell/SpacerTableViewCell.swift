//
//  SpacerTableViewCell.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SpacerTableViewCell: BaseDarkTableViewCell {
    @IBOutlet weak var spacerHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
}
