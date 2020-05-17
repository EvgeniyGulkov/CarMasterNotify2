//
//  CarMasterApi+Orders.swift
//  CarMasterNotify
//
//  Created by Gulkov on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Moya

extension CarMasterApi {
    enum Orders {
        case getOrders (request: CarMasterOrderRequest)
    }
}

extension CarMasterApi.Orders: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .getOrders: return .bearer
        }
    }
    
    var baseURL: URL {
        return Constants.CarMasterApi.baseUrl
    }
    
    var path: String {
        switch self {
        case .getOrders: return "/api/carorders"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getOrders: return .get
        }
    }
        
    var sampleData: Data {
        return Data()
    }
        
    var task: Task {
        switch self {
        case .getOrders (let request):
            return .requestParameters(
                parameters: request.json,
                encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

