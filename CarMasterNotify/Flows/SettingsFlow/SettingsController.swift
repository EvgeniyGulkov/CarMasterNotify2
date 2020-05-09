import UIKit
import RxSwift
import RxCocoa

class SettingsController: UITableViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var shortName: UILabel!
    @IBOutlet weak var signOutButton: RoundCornerButton!
    
    var viewModel: SettingsViewModel?

    override func viewDidLoad() {
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.viewWillAppear.onNext(())
    }
    
    func setupBindings() {
        self.viewModel?.user!
            .bind(to: self.shortName.rx.text)
            .disposed(by: disposeBag)
        
        self.signOutButton.rx.tap
            .bind(to: self.viewModel!.signOutButton)
            .disposed(by: disposeBag)
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectSettings.onNext(indexPath)
    }
}
