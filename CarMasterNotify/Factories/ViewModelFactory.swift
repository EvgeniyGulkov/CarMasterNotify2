import UIKit

class ViewModelFactory {
    
    static func makeDetailViewModel(order: OrderModel) -> DetailViewModel {
        let networkProvider = NetworkProvider()
        return DetailViewModel(order: order, networkProvider: networkProvider)
    }
    
    static func makeLoginViewModel() -> LoginViewModel {
        let networkProvider = NetworkProvider()
        let viewModel = LoginViewModel(networkProvider: networkProvider)
        return viewModel
    }
    
    static func makeSettingsViewModel() -> SettingsViewModel {
        let viewModel = SettingsViewModel()
        return viewModel
    }
    
    static func makePasswordDialogueViewModel() -> PasswordDialogueViewModel {
        let viewModel = PasswordDialogueViewModel()
        return viewModel
    }
    
    static func makeNameDialogueViewModel() -> NameChangeViewModel {
        let viewModel = NameChangeViewModel()
        return viewModel
    }
    
    static func makeOrderViewModel() -> OrderViewModel {
        let networkProvider = NetworkProvider()
        let viewModel = OrderViewModel(networkProvider: networkProvider)
        return viewModel
    }
}
