//
//  TokenModel.swift
//  CarMasterNotify
//
//  Created by Admin on 22.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct TokenModel: Codable {
    var accessToken: String?
    var refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
