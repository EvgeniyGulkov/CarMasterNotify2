import Moya

extension CarMasterApi: TargetType, AccessTokenAuthorizable {

    var authorizationType: AuthorizationType? {
        switch self {
        case .getReasons:
            return .bearer
        case .getMessages:
            return .bearer
        case .changeStatus:
            return .bearer
        case .addMessage:
            return .bearer
        }
    }

    var baseURL: URL {
        return Constants.CarMasterApi.baseUrl
    }

    var path: String {
        switch self {
        case .getReasons:
            return "/api/reasons"
        case .getMessages:
            return "/api/recommendations"
        case .changeStatus:
            return "/api/reasons/changestatus"
        case .addMessage:
            return "/api/recommendations/add"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getReasons:
            return .get
        case .getMessages:
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
        case .getReasons(let orderNumber):
            return .requestParameters(parameters: ["ordernumber" : orderNumber], encoding: URLEncoding.default)

        case .getMessages(let orderNumber):
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
