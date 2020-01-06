import UIKit

protocol AuthModuleFactory {
    func makeLoginOutput(viewModel: LoginViewModel) -> LoginController
}
