//
//  ForgotPasswordDataSource.swift
//  CarMasterNotify
//
//  Created by Admin on 16.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift
import RxDataSources

struct ForgotPasswordDataSource {

    var title: String
    var items: [Station]
}
extension ForgotPasswordDataSource: SectionModelType {

    init(original: ForgotPasswordDataSource, items: [Station]) {
        self.items = items
        self.title = original.title
    }

    init(items: [Station], title:String) {
        self.items = items
        self.title = title
    }
}
