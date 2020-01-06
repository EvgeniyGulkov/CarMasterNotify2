import UIKit

protocol OrderModuleFactory {
    func makeOrdersOutput(viewModel: OrderViewModel) -> OrderController
    func makeOrderDetailOutput(viewModel: DetailViewModel) -> DetailsController
}
