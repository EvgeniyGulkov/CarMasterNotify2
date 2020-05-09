import Foundation
import Moya

enum CarMasterApi {
    case refreshToken (refreshToken: String)
    case signIn (login: String, password: String)
    case getCars (offset: Int, limit: Int, searchText: String)
    case getReasons (orderNumber: Int)
    case getMessages (orderNumber: Int)
    case changeStatus(id: String)
    case addMessage(text: String, order: Int)
    case changeChatname(newChatname: String)
    case changePassword(currentPassword: String, newPassword: String)
}
