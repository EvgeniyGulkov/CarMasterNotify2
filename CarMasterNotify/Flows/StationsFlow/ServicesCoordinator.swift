import UIKit
import RxSwift
import SocketIO

final class StationsCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    private let factory: StationsModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, factory: StationsModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showStations()
    }
    
    private func showStations() {
        let viewModel = ViewModelFactory.makeStationsViewModel()
        viewModel.selectData
            .subscribe({ [unowned self] data in
                //self.showOrderDetail($0.element!,socketClient: viewModel.socketClient)
            })
            .disposed(by: disposeBag)
        viewModel.addButtonTouched
            .subscribe(onNext: { [weak self] in
                self?.showAddStation()
            })
            .disposed(by: disposeBag)
        let StationsOutput = factory.makeStationsOutput(viewModel: viewModel)
        router.setRootModule(StationsOutput)
    }

    private func showAddStation() {
        let viewModel = ViewModelFactory.makeSelectCompanyViewModel()
        let selectCompanyOutput = factory.makeAddStationOutput(viewModel: viewModel)
        router.push(selectCompanyOutput)
    }
}
