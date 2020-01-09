import Foundation

struct UserDataModel: Codable {
    var accessToken: String?
    var refreshToken: String?
    var userName: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userName = "username"
    }
}
