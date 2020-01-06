import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxDataSources

class OrderController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl:UIRefreshControl?
    var viewModel: OrderViewModel!
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        self.refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        self.createSearchController(navigationItem: self.navigationItem)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false;
    }
    
    private func setupBindings() {
        self.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.viewModel.getData()
            })
            .disposed(by: disposeBag)
            
        self.searchController?.searchBar.rx.text
            .orEmpty
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: self.viewModel.search)
            .disposed(by: disposeBag)
            
        
        self.viewModel.data
            .bind(to: tableView.rx.items(dataSource: DataSourcesFactory.getOrdersDataSource()))
            .disposed(by: disposeBag)
            
        self.viewModel.data
            .subscribe(onNext: {_ in
                self.refreshControl?.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(OrderModel.self)
            .bind(to: viewModel.selectData)
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .map{cell, index in return index.section*2+index.row+1}
            .bind(to: self.viewModel.displayLastCell)
            .disposed(by: disposeBag)
    }

    @objc
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.searchController!.searchBar.setShowsCancelButton(false, animated: true)
        self.searchController!.searchBar.endEditing(true)
    }
}
