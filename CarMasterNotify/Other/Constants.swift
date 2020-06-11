//
//  Constants.swift
//  CarMasterNotify
//
//  Created by Admin on 10.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct Constants {
    struct SecureManager {
        static let Station = "CarMasterStation"
        static let accessTokenKey = "AccessTokenKey"
        static let refreshTokenKey = "RefreshTokenKey"
        static let isAuthorizedKey = "IsAuthorizedKey"
    }

    struct CellIdentifiers {
        static let order = "OrderCellKey"
        static let details = "DetailsCellKey"
        static let carInfo = "CarInfoCellKey"
        static let textField = "TextFieldKey"
        static let button = "ButtonKey"
        static let error = "ErrorKey"
        static let spacer = "SpacerKey"
        static let twoButtons = "TwoButtonsKey"
        static let Station = "StationKey"
        static let user = "UserKey"
    }

    struct CarMasterApi {
        static let baseUrl = URL(string: "http://192.168.0.104:8000")!
    }
}
