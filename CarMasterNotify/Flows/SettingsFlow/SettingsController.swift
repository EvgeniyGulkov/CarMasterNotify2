import UIKit
import RxSwift
import RxCocoa

class SettingsController: BaseTableViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var signOutButton: RoundCornerButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var accessLevel: UILabel!
    @IBOutlet weak var position: DefaultTextLabel!
    
    var viewModel: SettingsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.borderWidth = 1.0
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let viewWillAppear = self.viewModel?.viewWillAppear{
            viewWillAppear.onNext(())
        }
    }
    
    func setupBindings() {
        self.viewModel?.nickName?
            .subscribe(onSuccess: { name in
                self.nickName.text = name
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)

        if let signOutButton = self.viewModel?.signOutButton {
            self.signOutButton.rx.tap
                .bind(to: signOutButton)
                .disposed(by: disposeBag)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.viewModel?.selectSettings?.onNext(indexPath)
    }
}
