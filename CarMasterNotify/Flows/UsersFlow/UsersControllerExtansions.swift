import UIKit
import RxDataSources

extension UsersController {
    func createSearchController(navigationItem: UINavigationItem) {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
}
