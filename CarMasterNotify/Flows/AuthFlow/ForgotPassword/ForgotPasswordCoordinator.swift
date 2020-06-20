//
//  ForgotPasswordCoordinator.swift
//  CarMasterNotify
//
//  Created by Admin on 14.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift

class ForgotPasswordCoordinator: BaseCoordinator {
    private let factory: ModuleFactoryImp
    private let router: Router
    private let disposeBag = DisposeBag()
    private var passwordFlowRouter: Router?

    init(router: Router, factory: ModuleFactoryImp) {
        self.factory = factory
        self.router = router
    }

    override func start() {
        let viewModel = ViewModelFactory.makeForgotPasswordEnterEmailViewModel()
        viewModel.showEnterCodeScreen = showEnterCodeScreen
        viewModel.finishFlow = close
        let controller = factory.makeEnterEmailOutput(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: controller)
        passwordFlowRouter = RouterImp(rootController: navigationController)
        router.present(navigationController, animated: true)
    }

    private func showEnterCodeScreen() {
        let controller = ForgotPasswordSendCodeController.controllerFromStoryboard(.forgotPasswordSendCode)
        let viewModel = ForgotPasswordSendCodeViewModel(networkProvider: CustomMoyaProvider<CarMasterApi>())
        viewModel.finishFlow = close
        controller.viewModel = viewModel
        passwordFlowRouter?.push(controller, animated: true)
    }

    private func close() {
        router.dismissModule(animated: true, completion: nil)
    }
}
