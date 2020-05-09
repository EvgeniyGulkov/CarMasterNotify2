import UIKit
import RxKeyboard
import RxSwift
import RxCocoa
import RxDataSources
import CoreData


class DetailsController: UIViewController {
    
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var carInfoText: UILabel!

    private let firstSegment = "Reasons"
    private let secondSegment = "Comments"
    private let disposeBag = DisposeBag()
    
    private var autoScrollOn: Bool = true
    var handler: ((DetailsController, Int)->())?
    var refreshControl: UIRefreshControl?
    
    var viewModel: DetailViewModel?
    var segment: UISegmentedControl?
    
    var fetchedMessageController: NSFetchedResultsController<Message>!
    var fetchedReasonsController: NSFetchedResultsController<Reason>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        
    }
    
    func setupUI() {
        self.refreshControl = UIRefreshControl()
        
        segment = UISegmentedControl(items: [firstSegment, secondSegment])
        segment!.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.detailsTableView.addGestureRecognizer(tapGesture)
        self.detailsTableView.scrollToBottom(animated: false)
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
                    self.detailsTableView.refreshControl = nil
                    self.messageViewHeightConstraint.constant = 44
                    self.detailsTableView.separatorStyle = .none
                default:
                    self.detailsTableView.refreshControl = self.refreshControl
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
            })
            .disposed(by: disposeBag)
        
        self.detailsTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.detailsTableView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        self.detailsTableView.rx.contentOffset
            .subscribe(onNext: {[unowned self] size in
                if size.y + self.detailsTableView.frame.height < self.detailsTableView.contentSize.height {
                    self.autoScrollOn = false
                } else {
                    self.autoScrollOn = true
                }
            })
            .disposed(by: disposeBag)
        
     //   self.viewModel?.data
     //       .subscribe(onNext: {[unowned self] data in
     //           if self.autoScrollOn {
    //                self.detailsTableView.scrollToBottom(animated: true)
    //            }
    //        })
    //        .disposed(by: disposeBag)

        sendMessageButton.rx.tap
            .flatMap{_ in return Observable.just(self.messageField.text)}
            .bind(to: self.viewModel!.newMessage)
            .disposed(by: disposeBag)
        
        self.detailsTableView.rx.willDisplayCell
            .subscribe(onNext: {cell, indexPath in
                if self.segment?.selectedSegmentIndex == 1 {
                    if indexPath.row == 1 {
                        self.detailsTableView.isScrollEnabled = false
                        self.detailsTableView.scrollToRow(at: IndexPath(item: 10, section: 0), at: .middle, animated: true)
                    }
                self.viewModel?.loadMore.onNext(indexPath.row)
                }
            })
            .disposed(by: disposeBag)
        }
    
    @objc func dismissKeyboard(_ : UITapGestureRecognizer) {
        messageField.resignFirstResponder()
    }
}
