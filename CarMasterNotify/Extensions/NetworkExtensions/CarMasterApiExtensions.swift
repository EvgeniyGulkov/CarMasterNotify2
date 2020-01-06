import Foundation
import Moya

extension CarMasterApi: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        switch self {
        case .signIn:
            return .none
        case .getCars:
            return .bearer
        case .getReasons:
            return .bearer
        case .getRecommendations:
            return .bearer
        case .changeStatus:
            return .bearer
        case .addMessage:
            return .bearer
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://www.carmasterapi.me.uk:443")!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/oauth/token"
        case .getCars:
            return "/api/carorders"
        case .getReasons:
            return "/api/reasons"
        case .getRecommendations:
            return "/api/recommendations"
        case .changeStatus:
            return "/api/reasons/changestatus"
        case .addMessage:
            return "/api/recommendations/add"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        case .getCars:
            return .get
        case .getReasons:
            return .get
        case .getRecommendations:
            return .get
        case .changeStatus:
            return .post
        case .addMessage:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signIn ( let login, let password):
        return .requestParameters(
            parameters: [
                "username": login,
                "password": password,
                "grant_type": "password",
                "client_id": "1C",
                "client_secret": "SomeRandomCharsAndNumbers"],
            encoding: JSONEncoding.default)
            
        case .getCars(let offset, let limit,let searchText):
            return .requestParameters(parameters: ["limit" : limit, "offset": offset, "searchtext": searchText], encoding: URLEncoding.default)
            
        case .getReasons(let orderNumber):
            return .requestParameters(parameters: ["ordernumber" : orderNumber], encoding: URLEncoding.default)
            
        case .getRecommendations(let orderNumber):
            return .requestParameters(parameters: ["ordernumber" : orderNumber], encoding: URLEncoding.default)
            
        case .changeStatus(let id):
            return .requestParameters(
                parameters: [
                    "id": id,
                    "reasonStatus": true
                ],
                encoding: JSONEncoding.default)
            
        case .addMessage(let text, let order):
            return .requestParameters(parameters: ["message" : text, "orderNum" : order], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
