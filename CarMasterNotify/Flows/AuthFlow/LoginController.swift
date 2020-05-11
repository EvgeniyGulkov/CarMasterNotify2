import UIKit
import RxCocoa
import RxSwift

class LoginController: UIViewController {
    @IBOutlet weak var loginText: RoundedCornerTextField!
    @IBOutlet weak var passwordText: RoundedCornerTextField!
    @IBOutlet weak var signInButton: RoundedCornerButton!
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var textfieldsContainerView: UIView!
    private let disposeBag = DisposeBag()
    
    var viewModel:LoginViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        textfieldsContainerView.backgroundColor = Theme.Color.tableSectionBackground
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
