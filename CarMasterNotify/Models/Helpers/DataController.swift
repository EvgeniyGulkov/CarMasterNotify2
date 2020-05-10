import CoreData
import UIKit

class DataController {

    static var shared: DataController!

    let main: NSManagedObjectContext
    let background: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer

    private lazy var all: [NSManagedObjectContext] = {
        return [background, main]
    }()

    private init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        main = persistentContainer.viewContext
        main.mergePolicy = NSOverwriteMergePolicy
        background = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        background.parent = main
        background.automaticallyMergesChangesFromParent = true
        background.mergePolicy = NSOverwriteMergePolicy
    }

    static func create(persistentContainer: NSPersistentContainer, _ completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print(error)
                fatalError("Failed to load Core Data stack: \(error)")
            }
            shared = DataController(persistentContainer: persistentContainer)
            completion()
        }
    }

    func removeAll() {
        save()
        let coordinator = persistentContainer.persistentStoreCoordinator
        do {
            for entity in coordinator.managedObjectModel.entities {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    try main.execute(deleteRequest)
            }
        } catch let error as NSError {
            print(error)
        }
        save()
    }

    func save() {
        for context in all {
            save(context)
        }
    }

    func save(_ context: NSManagedObjectContext) {
            guard context.hasChanges else {
                return
            }
            do {
                try context.save()
            } catch let error as NSError {
                print(error)
        }
    }
}

