import UIKit
import RxSwift
import SocketIO

enum ActionStrings: String {
    case complete = "Complete"
    case cancel = "Cancel"
    case message = "Mark Reason as Complete?"
    case ok = "Ok"
}

final class OrderCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    private let factory: OrderModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, factory: OrderModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showOrders()
    }
    
    private func showOrders() {
        let viewModel = ViewModelFactory.makeOrderViewModel()
        viewModel.selectData
            .subscribe({ [unowned self] in
                self.showOrderDetail($0.element!,socketClient: viewModel.socketClient)
            })
            .disposed(by: disposeBag)
        let ordersOutput = factory.makeOrdersOutput(viewModel: viewModel)
        router.setRootModule(ordersOutput)
    }
        
    private func showOrderDetail(_ order: Order, socketClient: SocketClient<CarMasterSocketApi>) {
        let viewModel = ViewModelFactory.makeDetailsViewModel(order: order)
        let controller = factory.makeDetailsOutput(viewModel: viewModel)
        controller.title = "Order details"
        router.push(controller)
        }
    
    func showCompleteAction() -> (DetailsController, Int) -> () {
        return { controller, index in
            let completeMenu = UIAlertController(title: nil, message: ActionStrings.message.rawValue, preferredStyle: .actionSheet)
                 
            let markCompleteAction = UIAlertAction(title: ActionStrings.ok.rawValue, style: .default, handler: {action in //controller.viewModel!.changeStatus(index: index)
            })
            let cancelAction = UIAlertAction(title: ActionStrings.cancel.rawValue, style: .cancel, handler: nil)
                completeMenu.addAction(markCompleteAction)
                completeMenu.addAction(cancelAction)
              
            if let popoverPresentationController = completeMenu.popoverPresentationController {
                popoverPresentationController.sourceView = controller.view
                popoverPresentationController.sourceRect = CGRect(x: controller.view.bounds.midX, y: controller.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
                }
                self.router.present(completeMenu, animated: true)
            }
    }
}
