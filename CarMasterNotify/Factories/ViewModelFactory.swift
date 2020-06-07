import UIKit
import SocketIO

class ViewModelFactory {
    
    static func makeDetailsViewModel(order: Order) -> DetailsViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        return DetailsViewModel(order: order, networkProvider: networkProvider)
    }
    
    static func makeMessageViewModel(order: Order, socketClient: SocketClient<CarMasterSocketApi> ) -> MessageViewModel {
        return MessageViewModel(order: order, socketClient: socketClient)
    }
    
    static func makeLoginViewModel() -> LoginViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi.Auth>()
        let viewModel = LoginViewModel(networkProvider: networkProvider)
        return viewModel
    }

    static func makeSignUpViewModel() -> SignUpViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi.Auth>()
        let viewModel = SignUpViewModel(networkProvider: networkProvider)
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

    static func makeUsersViewModel() -> UsersViewModel {
        let socketClient = SocketClient<CarMasterSocketApi>()
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = UsersViewModel(networkProvider: networkProvider,
                                       socketClient: socketClient)
        return viewModel
    }

    static func makeStationsViewModel() -> StationsViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = StationsViewModel(networkProvider: networkProvider)
        return viewModel
    }
    
    static func makeOrderViewModel() -> OrderViewModel {
        let socketClient = SocketClient<CarMasterSocketApi>()
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = OrderViewModel(networkProvider: networkProvider, socketClient: socketClient)
        return viewModel
    }

    static func makeSelectCompanyViewModel() -> AddStationViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = AddStationViewModel(networkProvider: networkProvider)
        return viewModel
    }
}
