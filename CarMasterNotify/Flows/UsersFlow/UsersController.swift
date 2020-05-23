import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxDataSources

class UsersController: BaseTableViewController {
    let disposeBag = DisposeBag()

    var viewModel: UsersViewModel!
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getData()
    }

    func setupUI() {
        self.title = "Users"
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.refreshControl = UIRefreshControl()
        self.createSearchController(navigationItem: self.navigationItem)
        self.createRefreshControl()
    }

    private func setupBindings() {
        self.searchController?.searchBar.searchTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: {[weak self] _ in
                self?.tableView.refreshControl = nil
            })
            .disposed(by: disposeBag)

        self.searchController?.searchBar.searchTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: {[weak self] _ in
                self?.createRefreshControl()
            })
            .disposed(by: disposeBag)

        self.searchController?.searchBar.rx.text
            .orEmpty
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: self.viewModel.search)
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.viewModel.data
            .bind(to: tableView.rx.items(dataSource: DataSourcesFactory.getOrdersDataSource()))
            .disposed(by: disposeBag)

        self.viewModel.data
            .subscribe(onNext: {[weak self] _ in
                self?.refreshControl?.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Order.self)
            .bind(to: viewModel.selectData)
            .disposed(by: disposeBag)

        tableView.rx.willDisplayCell
            .map{cell, index in return index.section*2+index.row+1}
            .bind(to: self.viewModel.displayLastCell)
            .disposed(by: disposeBag)
    }

    private func createRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.viewModel.getData()
            })
            .disposed(by: disposeBag)
    }
}
