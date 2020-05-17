//
//  CarMasterApi+Auth.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import Foundation
import Moya

extension CarMasterApi {
    enum Auth {
        case signIn(request: CarMasterSignInRequest)
        case refreshToken (request: CarMasterRefreshTokenRequest)

    }
}

extension CarMasterApi.Auth: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .signIn: return .bearer
        case .refreshToken: return .bearer
        }
    }
    
    var baseURL: URL {
        return Constants.CarMasterApi.baseUrl
    }
    
    var path: String {
        switch self {
        case .signIn, .refreshToken: return "/oauth/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .refreshToken: return .post
        }
    }
        
    var sampleData: Data {
        return Data()
    }
        
    var task: Task {
        switch self {
        case .signIn (let request):
            return .requestParameters(
                parameters: request.json,
                encoding: JSONEncoding.default)
        case .refreshToken(let request):
                 return .requestParameters(
                    parameters: request.json,
                 encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
