import UIKit
import RxCocoa
import RxSwift

class LoginController: BaseTableViewController {
    @IBOutlet weak var spacerHeight: NSLayoutConstraint!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginText: DefaultTextField!
    @IBOutlet weak var passwordText: DefaultTextField!
    @IBOutlet weak var signInButton: RoundedCornerButton!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var viewModel:LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        errorTextLabel.text = "blabla"
        spacerHeight.constant = self.view.frame.height*0.3
        tableView.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupBindings() {
        signInButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map{_ in
                let request = CarMasterSignInRequest(login: self.loginText.text!,
                                                  password: self.passwordText.text!)
                return request }
            .bind(to: self.viewModel!.signInButton)
            .disposed(by: disposeBag)

    //    forgotPasswordButton.rx.tap
    //        .observeOn(MainScheduler.instance)
    //        .bind(to: self.viewModel!.forgotPasswordButton)
    //        .disposed(by: disposeBag)

        signUpButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(to: self.viewModel!.sighUpButton)
            .disposed(by: disposeBag)
        
        self.viewModel?.checkFields
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] isEnabled in
                self?.signInButton.setEnabled(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
        
        self.loginText.rx.text
            .orEmpty
            .observeOn(MainScheduler.instance)
            .bind(to: self.viewModel!.loginText)
            .disposed(by: disposeBag)

        self.passwordText.rx.text
            .orEmpty
            .observeOn(MainScheduler.instance)
            .bind(to: self.viewModel!.passwordText)
            .disposed(by: disposeBag)

        self.viewModel?.errorMessage
            .subscribe(onNext: { text in
               // self.errorTextLabel.text = text
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
