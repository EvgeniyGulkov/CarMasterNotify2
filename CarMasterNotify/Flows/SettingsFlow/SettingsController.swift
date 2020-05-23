import UIKit
import RxSwift
import RxCocoa

class SettingsController: BaseTableViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var accessLevel: UILabel!
    @IBOutlet weak var position: DefaultTextLabel!
    @IBOutlet weak var fullName: DefaultTextLabel!
    
    var viewModel: SettingsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Settings"
        tableView.dataSource = self
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let viewWillAppear = self.viewModel?.viewWillAppear{
            viewWillAppear.onNext(())
        }
    }
    
    func setupBindings() {
        self.viewModel?.nickName
            .subscribe(onSuccess: { name in
                self.nickName.text = name
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)

        self.viewModel?.accessLevel
            .bind(to: self.accessLevel.rx.text)
            .disposed(by: disposeBag)
        
        if let signOutButton = self.viewModel?.signOutButton {
            self.signOutButton.rx.tap
                .bind(to: signOutButton)
                .disposed(by: disposeBag)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectSettings.onNext(indexPath)
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = Theme.Color.blueColor
    }
}
