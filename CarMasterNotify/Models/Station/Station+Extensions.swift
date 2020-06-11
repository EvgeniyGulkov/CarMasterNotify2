//
//  Station+Extensions.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

extension Station {
    var isCurrent: Bool {
        if user == nil {
            return false
        } else {
            return true
        }
    }
}
