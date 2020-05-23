//
//  ErrorTextTableViewCell.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ErrorTextTableViewCell: BaseDarkTableViewCell {

    @IBOutlet weak var errorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    override func setupBindings() {
                viewModel.textLabel
                    .subscribe(onNext: { text in
                        self.backgroundColor = UIColor.red
                        self.errorLabel.text = text
                        print(self.errorLabel.text)
                    })
            .disposed(by: disposeBag)
    }
}
