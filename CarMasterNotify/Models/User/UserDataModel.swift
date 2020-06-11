import Foundation

struct UserDataModel: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?

    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case phone = "phoneNumber"
    }
}
