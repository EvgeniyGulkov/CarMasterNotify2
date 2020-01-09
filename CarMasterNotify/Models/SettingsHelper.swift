import Foundation
import KeychainAccess

class SettingsHelper {
    private static let keychain = Keychain()

    static let userName: String! = UserDefaults.standard.string(forKey: "user_name") ?? ""
    
    static func saveUserData(userdata: UserDataModel) {
        try? self.keychain.set((userdata.accessToken!), key: "access_token")
        try? self.keychain.set((userdata.refreshToken!), key: "refresh_token")
        UserDefaults.standard.setValue(userdata.userName!, forKey: "user_name")
    }
    
    static func accessToken() -> String {
        let token = try? Keychain().getString("access_token")
        return token!
    }
    
    static func refreshToken() -> String {
        let token = try? Keychain().getString("refresh_token")
        return token!
    }
}
