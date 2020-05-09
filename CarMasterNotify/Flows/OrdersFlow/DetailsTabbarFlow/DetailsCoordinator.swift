//
//  DetailsCoordinator.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import UIKit

class DetailsCoordinator: BaseCoordinator {
    private let factory: DetailsModuleFactory
    private let router: Router
    private let socketClient: SocketClient<CarMasterSocketApi>
    private let order: Order
    
    var controller:DetailsTabbarController
    var reasonsNavController: UINavigationController
    var messagesNavController: UINavigationController
    
    init(order: Order, router: Router,factory: DetailsModuleFactory, socketClient: SocketClient<CarMasterSocketApi>) {
        self.factory = factory
        self.router = router
        self.order = order
        self.socketClient = socketClient
        self.controller = factory.makeDetailsTabbarOutput()
        self.reasonsNavController = controller.viewControllers![0] as! UINavigationController
        self.reasonsNavController.view.backgroundColor = UIColor.white
        self.messagesNavController = controller.viewControllers![1] as! UINavigationController
    }
    
    override func start() {
        self.router.push(self.controller)
        runReasonsFlow(in: self.reasonsNavController)
        runMessagesFlow(in: self.messagesNavController)
    }
    
    private func runReasonsFlow(in navController: UINavigationController) {
        if navController.viewControllers.isEmpty {
            let router = RouterImp(rootController: navController)
            let viewModel = ViewModelFactory.makeReasonViewModel(order: self.order)
            let controller = factory.makeReasonsOutput(viewModel: viewModel)
            router.setRootModule(controller)
        }
    }
    
    private func runMessagesFlow(in navController: UINavigationController) {
        if navController.viewControllers.isEmpty {
            let router = RouterImp(rootController: navController)
            let viewModel = ViewModelFactory.makeMessageViewModel(order: self.order, socketClient: self.socketClient)
            let controller = factory.makeMessagesOutput(viewModel: viewModel)
            router.setRootModule(controller)
        }
    }
}
