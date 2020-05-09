import UIKit
import CoreData

class CoreDataManager {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let context = appDelegate?.persistentContainer.viewContext
    
    static func save() {
        do {
            try context?.save()
        } catch {
            print(error)
        }
    }
}
