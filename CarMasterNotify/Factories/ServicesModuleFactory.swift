import UIKit

protocol StationsModuleFactory {
    func makeStationsOutput(viewModel: StationsViewModel) -> StationsController
    func makeAddStationOutput(viewModel: AddStationViewModel) -> AddStationController
}
