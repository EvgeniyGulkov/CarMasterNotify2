//
//  StationTableViewCell.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class StationTableViewCell: BaseDarkTableViewCell {
    @IBOutlet weak var StationLogo: UIImageView!
    @IBOutlet weak var StationName: DefaultTextLabel!
    @IBOutlet weak var StationAddress: DefaultTextLabel!
    @IBOutlet weak var roundedView: UIView!
    var viewModel: StationTableViewCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = StationTableViewCellViewModel()
        backgroundColor = .clear
        roundedView.backgroundColor = Theme.Color.tableSectionBackground
        roundedView.layer.borderColor = UIColor.lightGray.cgColor

        viewModel.selected
            .subscribe(onNext: {[weak self] selected in
                if selected {
                    self?.roundedView.layer.borderWidth = 1
                } else {
                    self?.roundedView.layer.borderWidth = 0
                }
            })
        .disposed(by: disposeBag)
    }
}
