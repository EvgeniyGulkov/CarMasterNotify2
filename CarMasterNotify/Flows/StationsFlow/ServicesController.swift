import RxSwift
import RxCocoa
import RxKeyboard
import RxDataSources

class StationsController: BaseTableViewController {
    let disposeBag = DisposeBag()

    var viewModel: StationsViewModel!
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        self.title = "Stations"
        tableView.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.createRefreshControl()
    }

    private func setupBindings() {
        self.viewModel.data
            .do(onNext: {[weak self] _ in self?.refreshControl?.endRefreshing()})
            .bind(to: tableView.rx.items(dataSource: StationDataSourceFactory.stationDataSource(viewModel: self.viewModel)))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Station.self)
            .bind(to: viewModel.selectData)
            .disposed(by: disposeBag)

        tableView.rx.willDisplayCell
            .map {_, index in return index.section*2+index.row+1}
            .bind(to: self.viewModel.displayLastCell)
            .disposed(by: disposeBag)

        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind(to: self.viewModel.addButtonTouched)
            .disposed(by: disposeBag)
    }

    private func createRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.refreshControl?.endRefreshing()
                //self.viewModel.getData()
            })
            .disposed(by: disposeBag)
    }
}
