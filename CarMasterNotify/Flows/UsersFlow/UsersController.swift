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
        tableView.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addUserButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let calendarButton = UIBarButtonItem(image: UIImage(named: "calendar"), style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [addUserButton, calendarButton]
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
        
        self.viewModel.data
            .do(onNext: {[weak self] _ in self?.refreshControl?.endRefreshing()})
            .bind(to: tableView.rx.items(dataSource: UsersDataSourcesFactory.usersDataSource()))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(User.self)
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
