import UIKit
import RxDataSources

extension OrderController: UITableViewDelegate {
    func createSearchController(navigationItem: UINavigationItem) {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        }
    
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.textLabel?.textAlignment = .center
        }
}
