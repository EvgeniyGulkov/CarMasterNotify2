import Foundation

struct UserDataModel: Codable {
    var accessToken: String?
    var refreshToken: String?
    var login: String?
    var chatName: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case chatName = "chatname"
        case login = "username"
    }
}
