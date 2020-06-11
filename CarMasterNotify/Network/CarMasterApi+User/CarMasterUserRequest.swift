//
//  CarMasterUserRequest.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftyJSON

struct CarMasterChangeNicknameRequest {
    var json: [String: Any] = [:]

    init(newNickname: String) {
        json["chatname"] = newNickname
    }
}

struct CarMasterChangePasswordRequest {
    var json: [String: Any] = [:]

    init(currentPassword: String, newPassword: String) {
        json["currentpassword"] = currentPassword
        json["newpassword"] = newPassword
    }
}
