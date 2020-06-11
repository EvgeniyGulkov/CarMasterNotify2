import RxSwift
import SocketIO

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

    func showCompleteAction() -> (DetailsController, Int) -> Void {
        return { controller, index in
            let completeMenu = UIAlertController(title: nil, message: "Need to add string", preferredStyle: .actionSheet)

            let markCompleteAction = UIAlertAction(title: "Ok",
                                                   style: .default,
                                                   handler: {_ in //controller.viewModel!.changeStatus(index: index)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                completeMenu.addAction(markCompleteAction)
                completeMenu.addAction(cancelAction)

            if let popoverPresentationController = completeMenu.popoverPresentationController {
                popoverPresentationController.sourceView = controller.view
                popoverPresentationController.sourceRect = CGRect(x: controller.view.bounds.midX,
                                                                  y: controller.view.bounds.midY,
                                                                  width: 0,
                                                                  height: 0)
                popoverPresentationController.permittedArrowDirections = []
                }
                self.router.present(completeMenu, animated: true)
            }
    }
}
