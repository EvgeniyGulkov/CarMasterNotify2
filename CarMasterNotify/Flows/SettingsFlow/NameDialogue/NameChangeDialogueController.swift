import UIKit
import RxSwift
import RxCocoa

class NameChangeDialogueController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameTextField: RoundCornerTextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var viewModel: NameChangeViewModel?
    
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
        self.viewModel?.userName!.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: self.nameTextField.rx.text)
            .disposed(by: disposeBag)
        
         cancelButton.rx.tap
             .bind(to: self.viewModel!.tapCancel)
             .disposed(by: disposeBag)
         
         doneButton.rx.tap
            .map{return self.nameTextField.text!}
            .bind(to: self.viewModel!.tapDone)
            .disposed(by: disposeBag)
    }
     
    @objc
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.nameTextField.resignFirstResponder()
    }
    
}

