import Foundation
import Moya

enum CarMasterApi {
    case getReasons (orderNumber: Int)
    case getMessages (orderNumber: Int)
    case changeStatus(id: String)
    case addMessage(text: String, order: Int)
}
