import UIKit
import RxSwift

class SettingsController: UITableViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var shortName: UILabel!
    
    var viewModel: SettingsViewModel?

    override func viewDidLoad() {
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.viewWillAppear.onNext(())
    }
    
    func setupBindings() {
        self.viewModel?.userName!
        .bind(to: self.shortName.rx.text)
        .disposed(by: disposeBag)
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectSettings.onNext(indexPath)
    }
}
