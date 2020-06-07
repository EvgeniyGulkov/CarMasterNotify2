import UIKit
import RxSwift
import RxCocoa

class NameChangeDialogueController: BaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameTextField: UITextField!
    var doneButton: UIBarButtonItem?
    var viewModel: NameChangeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelItem
     }
     
    func setupBindings() {
        self.viewModel?.userName!.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: self.nameTextField.rx.text)
            .disposed(by: disposeBag)
         
         doneButton?.rx.tap
            .map{return self.nameTextField.text!}
            .bind(to: self.viewModel!.tapDone)
            .disposed(by: disposeBag)
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = Theme.Color.blueColor
    }

    @objc
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

