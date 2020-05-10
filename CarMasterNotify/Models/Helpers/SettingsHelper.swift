import Foundation
import KeychainAccess
import CoreData

enum DataBaseKeys: String {
    case chatName = "chatName"
    
}

class SettingsHelper {
    private let keychain = Keychain()
    var managedContext: NSManagedObjectContext?

    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        self.managedContext = appDelegate.persistentContainer.viewContext
    }

    func saveUserData(userdata: UserDataModel) {
        let user = User(context: managedContext!)
        user.login = userdata.login
        user.nickName = userdata.login
        CoreDataManager.save()

        try? self.keychain.set((userdata.accessToken!), key: "access_token")
        try? self.keychain.set((userdata.refreshToken!), key: "refresh_token")
    }
    
    func removeUserData() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        if let entity = try? self.managedContext?.fetch(fetchRequest) {
            for user in entity {
                managedContext?.delete(user)
            }
            try! managedContext?.save()
        }
        try? self.keychain.removeAll()
    }
    
    static func accessToken() -> String {
        let token = try? Keychain().getString("access_token")
        return token ?? ""
    }
    
    static func refreshToken() -> String {
        let token = try? Keychain().getString("refresh_token")
        return token ?? ""
    }
    
    
}
