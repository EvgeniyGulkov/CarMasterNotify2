//
//  CarMasterOrderRequest.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CarMasterOrderRequest {
    var json: [String: Any] = [:]

    init(offset: Int, limit: Int, searchText: String) {
        json["offset"] = offset
        json["limit"] = limit
        json["searchtext"] = searchText
    }
}
