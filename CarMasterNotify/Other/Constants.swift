//
//  Constants.swift
//  CarMasterNotify
//
//  Created by Admin on 10.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Constants {
    struct SecureManager {
        static let service = "CarMasterService"
        static let accessTokenKey = "AccessTokenKey"
        static let refreshTokenKey = "RefreshTokenKey"
        static let isAuthorizedKey = "IsAuthorizedKey"
    }

    struct CellIdentifiers {
        static let order = "OrderCellKey"
        static let details = "DetailsCellKey"
        static let carInfo = "CarInfoCellKey"
    }
}
