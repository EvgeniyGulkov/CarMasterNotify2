import UIKit

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
