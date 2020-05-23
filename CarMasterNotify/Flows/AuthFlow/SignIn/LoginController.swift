import UIKit
import RxCocoa
import RxSwift

class LoginController: BaseTableViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel:LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        tableView.refreshControl = UIRefreshControl()
        self.viewModel?.spacer = Observable.just(self.view.frame.height * 0.3)
        tableView.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupBindings() {
        self.viewModel?.data
            .bind(to: tableView.rx.items(dataSource: AuthDataSourceFactory.loginDataSource(viewModel: self.viewModel!)))
            .disposed(by: disposeBag)

        self.tableView.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}
