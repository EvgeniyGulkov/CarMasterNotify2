import RxSwift
import RxCocoa

class PasswordDialogueController: BaseTableViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var currentPassword: DefaultTextField!
    @IBOutlet weak var newPassword: DefaultTextField!
    @IBOutlet weak var confirmPassword: DefaultTextField!
    var doneButton: UIBarButtonItem?

    var viewModel: PasswordDialogueViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        setupUI()
        setupBindings()
    }

    func setupUI() {
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        let canceButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = canceButton
    }

    func setupBindings() {
        self.navigationItem.leftBarButtonItem?.rx.tap
            .bind(to: self.viewModel!.tapCancel)
            .disposed(by: disposeBag)

        doneButton?.rx.tap
            .bind(to: self.viewModel!.tapDone)
            .disposed(by: disposeBag)
    }

    @objc
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
