//
//  StationDataSource.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct StationDataSource {
    
    var title: String
    var items: [Station]
}
extension StationDataSource: SectionModelType {
    
    init(original: StationDataSource, items: [Station]) {
        self.items = items
        self.title = original.title
    }
    
    init(items: [Station], title:String) {
        self.items = items
        self.title = title
    }
}
