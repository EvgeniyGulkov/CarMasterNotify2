import Foundation

struct TokensModel: Codable {
    var accessToken: String?
    var expires_in: Int?
    var refreshToken: String?
    var token_type: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
