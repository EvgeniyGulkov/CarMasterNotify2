import UIKit
import RxKeyboard
import RxSwift
import RxCocoa
import RxDataSources


class DetailsController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var carInfoText: UILabel!

    private let firstSegment = "Reasons"
    private let secondSegment = "Recommendations"
    private let disposeBag = DisposeBag()
    
    var handler: ((DetailsController, Int)->())?
    var refreshControl: UIRefreshControl?
    
    var viewModel: DetailViewModel?
    var segment: UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        self.refreshControl = UIRefreshControl()
        detailsTableView.refreshControl = refreshControl
        
        segment = UISegmentedControl(items: [firstSegment, secondSegment])
        segment!.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.detailsTableView.addGestureRecognizer(tapGesture)
    }
    
    func setupBindings() {
        self.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.viewModel?.getData(index: self.segment!.selectedSegmentIndex)
            })
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
        .drive(onNext: { [unowned self] in
            if $0 != 0 {
                self.bottomConstraint.constant = $0 - self.view.safeAreaInsets.bottom
            } else {
                self.bottomConstraint.constant = 0
            }
            self.detailsTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
            self.animate()
        })
        .disposed(by: disposeBag)
        
        viewModel?.title
            .observeOn(MainScheduler.instance)
            .bind(to: self.carInfoText.rx.text)
            .disposed(by: disposeBag)
        
        segment!.rx.selectedSegmentIndex
            .do(onNext: { [unowned self] in
                switch $0 {
                case 1:
                    self.messageViewHeightConstraint.constant = 44
                    self.detailsTableView.separatorStyle = .none
                default:
                    self.messageViewHeightConstraint.constant = 0
                    self.detailsTableView.separatorStyle = .singleLine
                    self.messageField.resignFirstResponder()
                }
            })
            .bind(to: self.viewModel!.dataChanged)
            .disposed(by: disposeBag)
        
        self.viewModel?.dataChanged
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.detailsTableView.isHidden = true
                self.loadingIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        self.detailsTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.viewModel?.data
            .do(onNext: {_ in
                self.refreshControl?.endRefreshing()
                self.detailsTableView.isHidden = false
                self.loadingIndicator.stopAnimating()
            })
            .bind(to: self.detailsTableView.rx.items(dataSource: (DataSourcesFactory.getDetailsDatasource(viewModel: self.viewModel!))))
            .disposed(by: disposeBag)
        
        self.viewModel?.data
            .do(onNext: {_ in self.messageField.text = ""})
            .subscribe(onNext: {_ in
               self.detailsTableView.scrollToBottom(animated: false)
            })
            .disposed(by: disposeBag)

        sendMessageButton.rx.tap
            .flatMap{_ in return Observable.just(self.messageField.text)}
            .bind(to: self.viewModel!.newMessage)
            .disposed(by: disposeBag)
        }
    
    @objc func dismissKeyboard(_ : UITapGestureRecognizer) {
        messageField.resignFirstResponder()
    }
}
