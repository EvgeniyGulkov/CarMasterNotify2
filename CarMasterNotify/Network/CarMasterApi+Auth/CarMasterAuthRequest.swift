//
//  CarMasterAuthRequest.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftyJSON

struct CarMasterSignInRequest {
    var json: [String: Any] = [:]

    init(login: String, password: String) {
        json["username"] = login
        json["password"] = password
        json["grant_type"] = "password"
        json["client_id"] = "1C"
        json["client_secret"] = "SomeRandomCharsAndNumbers"
    }
}

struct CarMasterRefreshTokenRequest {
    var json: [String: Any] = [:]
}

struct CarMasterSignUpRequest {
    var json: [String: Any] = [:]

    init(user: UserDataModel, password: String) {
        json["firstName"] = user.firstName
        json["lastName"] = user.lastName
        json["password"] = password
        json["email"] = user.email
        json["phone"] = user.phone
    }
}
