//
//  BaseTableViewCell.swift
//  CarMasterNotify
//
//  Created by Gulkov on 09.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift

class BaseDarkTableViewCell: UITableViewCell {
    private (set) var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        if accessoryType == .disclosureIndicator {
            let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
            view.tintColor = Theme.Color.tIntColor
            view.image = UIImage(named: "disclosure")
            self.accessoryView = view
            self.selectionStyle = .none
        }
        self.backgroundColor = Theme.Color.tableSectionBackground
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
