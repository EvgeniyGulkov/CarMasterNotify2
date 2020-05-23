import UIKit

protocol ServicesModuleFactory {
    func makeServicesOutput(viewModel: ServicesViewModel) -> ServicesController
}
