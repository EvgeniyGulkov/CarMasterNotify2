import RxSwift

class SettingsCoordinator: BaseCoordinator {
    private let factory: SettingsModuleFactory
    private let router: Router
    private let disposeBag = DisposeBag()

    var finishFlow: (() -> Void)?

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

        viewModel.signOutButton.asObservable()
            .subscribe(onNext: {self.showSignOutAlert()})
            .disposed(by: disposeBag)

        let settingsOutput = factory.makeSettingsOutput(viewModel: viewModel)
        router.setRootModule(settingsOutput)
    }

    private func showPasswordChangeDialogue() {
        let viewModel = ViewModelFactory.makePasswordDialogueViewModel()
        let passwordChangeDialogueOutput = factory.makeChangePasswordDialogueOutput(viewModel: viewModel)
        let controller = NavigationController(rootViewController: passwordChangeDialogueOutput)
        controller.modalPresentationStyle = .fullScreen

        viewModel.tapCancel.asObservable()
            .subscribe(onNext: {passwordChangeDialogueOutput.dismiss(animated: true, completion: nil)})
            .disposed(by: disposeBag)

        viewModel.passwordChanged.asObservable()
            .subscribe(onNext: {passwordChangeDialogueOutput.dismiss(animated: true, completion: nil)})
            .disposed(by: disposeBag)

        router.present(controller, animated: true)
    }

    private func showNameChangeDialogue() {
        let viewmodel = ViewModelFactory.makeNameDialogueViewModel()
        let nameChangeDialogueOutput = factory.makeChangeNameDialogueOutput(viewModel: viewmodel)
        let controller = NavigationController(rootViewController: nameChangeDialogueOutput)
        controller.modalPresentationStyle = .fullScreen
        viewmodel.tapCancel.asObservable()
        .subscribe(onNext: {nameChangeDialogueOutput.dismiss(animated: true, completion: nil)})
        .disposed(by: disposeBag)

        viewmodel.nameChanged.asObservable()
            .subscribe(onNext: {nameChangeDialogueOutput.dismiss(animated: true, completion: nil)})
            .disposed(by: disposeBag)

        router.present(controller, animated: true)
    }

    private func showSignOutAlert() {
        let alertController = UIAlertController(title: "Sign Out",
                                                message: "Do you want to sign out?",
                                                preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: {_ in
            SecureManager.signOut()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        router.present(alertController)
    }
}
