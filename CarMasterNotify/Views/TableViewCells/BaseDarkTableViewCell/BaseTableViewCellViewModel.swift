//
//  BaseTableViewCellViewModel.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift

class BaseTableViewCellViewModel {
    var textLabel = PublishSubject<String>()

    init() {
        textLabel.subscribe(onNext: {print($0)}).dispose()
    }
}
