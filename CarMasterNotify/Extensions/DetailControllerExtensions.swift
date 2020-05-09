import UIKit
import CoreData

extension DetailsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self.completeAction()
    }
    
    func completeAction () -> [UITableViewRowAction] {
         let completeAction = UITableViewRowAction(style: .default, title: ActionStrings.complete.rawValue , handler: {
             (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
             self.handler!(self,indexPath.row)
         })
          completeAction.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 0/255, alpha: 255)
     return [completeAction]
     }
}

extension DetailsController: NSFetchedResultsControllerDelegate {
    
    func initializeMessageResultsController() {
        let context = CoreDataManager.context
         let request = NSFetchRequest<Message>(entityName: "Message")
         let sort = NSSortDescriptor(key: "created", ascending: false)
         request.sortDescriptors = [sort]
         fetchedMessageController = NSFetchedResultsController(fetchRequest: request,
                                              managedObjectContext: context!,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
         fetchedMessageController!.delegate = self
         
         do {
             try fetchedMessageController!.performFetch()
         } catch {
             print(error.localizedDescription)
         }
     }
    
    func initializeReasonsResultsController() {
        let context = CoreDataManager.context
         let request = NSFetchRequest<Reason>(entityName: "Reason")
         let sort = NSSortDescriptor(key: "created", ascending: false)
         request.sortDescriptors = [sort]
         fetchedReasonsController = NSFetchedResultsController(fetchRequest: request,
                                              managedObjectContext: context!,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
         fetchedReasonsController!.delegate = self
         
         do {
             try fetchedReasonsController!.performFetch()
         } catch {
             print(error.localizedDescription)
         }
     }
     
     func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         detailsTableView.beginUpdates()
     }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
         switch type {
         case .insert:
             detailsTableView.insertRows(at: [newIndexPath!], with: .fade)
         case .delete:
             detailsTableView.deleteRows(at: [newIndexPath!], with: .fade)
         case .move:
             detailsTableView.moveRow(at: indexPath!, to: newIndexPath!)
         case .update:
             detailsTableView.reloadRows(at: [indexPath!], with: .fade)
         @unknown default:
             break
         }
     }
     
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         detailsTableView.endUpdates()
     }
}

extension DetailsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
