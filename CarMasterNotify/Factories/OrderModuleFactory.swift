import UIKit

protocol OrderModuleFactory {
    func makeOrdersOutput(viewModel: OrderViewModel) -> OrderController
    func makeDetailsTabbarOutput() -> DetailsTabbarController
}
