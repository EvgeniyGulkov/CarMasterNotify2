import UIKit
import RxCocoa
import RxSwift

class LoginController: UIViewController {
    @IBOutlet weak var loginText: RoundCornerTextField!
    @IBOutlet weak var passwordText: RoundCornerTextField!
    @IBOutlet weak var signInButton: RoundCornerButton!
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var errorMessage: UILabel!
    private let disposeBag = DisposeBag()
    
    var viewModel:LoginViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupBindings() {
        signInButton.rx.tap
            .observeOn(MainScheduler.instance)
            .map{_ in return CarMasterApi.signIn(login: self.loginText.text!, password: self.passwordText.text!)}
            .bind(to: self.viewModel!.signInButton)
            .disposed(by: disposeBag)
        
        self.viewModel?.checkFields
            .observeOn(MainScheduler.instance)
            .bind(to: self.signInButton.rx.isEnabled)
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
        
        self.viewModel?.loading
            .subscribe(onNext: {[unowned self] isAnimated in
                if isAnimated {
                    self.loadIndicator.startAnimating()
                } else {
                    self.loadIndicator.stopAnimating()
                }
            })
        .disposed(by: disposeBag)
        
        self.viewModel?.loading
            .observeOn(MainScheduler.instance)
            .bind(to: self.errorMessage.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel?.errorMessage
            .observeOn(MainScheduler.instance)
            .bind(to: self.errorMessage.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        loginText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
}
