//
//  UserDataSource.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct UsersDataSource {
    
    var title: String
    var items: [User]
}
extension UsersDataSource: SectionModelType {
    
    init(original: UsersDataSource, items: [User]) {
        self.items = items
        self.title = original.title
    }
    
    init(items: [User], title:String) {
        self.items = items
        self.title = title
    }
}
