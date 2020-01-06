import UIKit
import RxSwift
import RxCocoa

class PasswordDialogueController: UIViewController {
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var currentPassword: RoundCornerTextField!
    @IBOutlet weak var newPassword: RoundCornerTextField!
    @IBOutlet weak var confirmPassword: RoundCornerTextField!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var viewModel: PasswordDialogueViewModel?
    
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
        cancelBtn.rx.tap
            .bind(to: self.viewModel!.tapCancel)
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .bind(to: self.viewModel!.tapDone)
            .disposed(by: disposeBag)
    }
    
    @objc
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.currentPassword.resignFirstResponder()
        self.newPassword.resignFirstResponder()
        self.confirmPassword.resignFirstResponder()
    }
}
