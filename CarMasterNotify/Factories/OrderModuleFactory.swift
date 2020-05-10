import UIKit

protocol OrderModuleFactory {
    func makeOrdersOutput(viewModel: OrderViewModel) -> OrderController
    func makeDetailsOutput(viewModel: DetailsViewModel) -> DetailsController
}
