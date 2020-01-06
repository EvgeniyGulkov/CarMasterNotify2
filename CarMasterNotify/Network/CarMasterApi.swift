import Foundation
import Moya

enum CarMasterApi {
    case signIn (login: String, password: String)
    case getCars (offset: Int, limit: Int, searchText: String)
    case getReasons (orderNumber: Int)
    case getRecommendations (orderNumber: Int)
    case changeStatus(id: String)
    case addMessage(text: String, order: Int)
}
