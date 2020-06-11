//
//  CarMasterApi+User.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Moya

extension CarMasterApi {
    enum User {
        case info
        case changeChatname(request: CarMasterChangeNicknameRequest)
        case changePassword(request: CarMasterChangePasswordRequest)
    }
}

extension CarMasterApi.User: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .info: return .bearer
        case .changeChatname: return .bearer
        case .changePassword: return .bearer
        }
    }

    var baseURL: URL {
        return Constants.CarMasterApi.baseUrl
    }

    var path: String {
        switch self {
        case .info:
            return "api/user/info"
        case .changeChatname:
            return "/api/user/changechatname"
        case .changePassword:
            return "/api/user/changepassword"
        }
    }

    var method: Moya.Method {
        switch self {
        case .info: return .get
        case .changePassword, .changeChatname: return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .changeChatname(let request):
            return .requestParameters(parameters: request.json, encoding: JSONEncoding.default)
        case .changePassword(let request):
            return .requestParameters(parameters: request.json, encoding: JSONEncoding.default)
        case .info:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
