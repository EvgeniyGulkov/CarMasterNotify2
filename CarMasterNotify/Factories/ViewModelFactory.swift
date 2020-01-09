import UIKit

class ViewModelFactory {
    
    static func makeDetailViewModel(order: OrderModel) -> DetailViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        return DetailViewModel(order: order, networkProvider: networkProvider)
    }
    
    static func makeLoginViewModel() -> LoginViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
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
    
    static func makeNameDialogueViewModel(username: String) -> NameChangeViewModel {
        let viewModel = NameChangeViewModel(username: username)
        return viewModel
    }
    
    static func makeOrderViewModel() -> OrderViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = OrderViewModel(networkProvider: networkProvider)
        return viewModel
    }
}
