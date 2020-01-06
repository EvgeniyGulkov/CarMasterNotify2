import UIKit
import RxSwift

class SettingsCoordinator: BaseCoordinator {
    private let factory: SettingsModuleFactory
    private let router: Router
    private let disposeBag = DisposeBag()
    
    init(router: Router, factory: SettingsModuleFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showSettings()
    }
    
    private func showSettings() {
        let viewModel = ViewModelFactory.makeSettingsViewModel()
        viewModel.showPasswordChangeDialogue = self.showPasswordChangeDialogue
        viewModel.showNameChangeDialogue = self.showNameChangeDialogue
        let settingsOutput = factory.makeSettingsOutput(viewModel: viewModel)
        settingsOutput.tabBarItem = UITabBarItem(title: settingsOutput.title!, image: UIImage(named: "settings_icon"), tag: 1)
        router.setRootModule(settingsOutput)
    }
    
    private func showPasswordChangeDialogue() {
        let viewModel = ViewModelFactory.makePasswordDialogueViewModel()
        let passwordChangeDialogueOutput = factory.makeChangePasswordDialogueOutput(viewModel: viewModel)
        
        viewModel.tapCancel.asObservable()
            .subscribe(onNext: {passwordChangeDialogueOutput.dismiss(animated: true, completion: nil)})
            .disposed(by: disposeBag)
        
        viewModel.passwordChanged.asObservable()
            .subscribe(onNext: {passwordChangeDialogueOutput.dismiss(animated: true, completion: nil)})
            .disposed(by: disposeBag)
        
        router.present(passwordChangeDialogueOutput, animated: true)
    }
    
    private func showNameChangeDialogue() {
        let viewmodel = ViewModelFactory.makeNameDialogueViewModel()
        let nameChangeDialogueOutput = factory.makeChangeNameDialogueOutput(viewModel: viewmodel)
        
        viewmodel.tapCancel.asObservable()
        .subscribe(onNext: {nameChangeDialogueOutput.dismiss(animated: true, completion: nil)})
        .disposed(by: disposeBag)
        
        viewmodel.nameChanged.asObservable()
            .subscribe(onNext: {nameChangeDialogueOutput.dismiss(animated: true, completion: nil)})
            .disposed(by: disposeBag)
        
        router.present(nameChangeDialogueOutput, animated: true)
    }
}
