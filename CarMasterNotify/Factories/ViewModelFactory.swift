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
    
    static func makeNameDialogueViewModel() -> NameChangeViewModel {
        let viewModel = NameChangeViewModel()
        return viewModel
    }
    
    static func makeOrderViewModel() -> OrderViewModel {
        let socketClient = SocketClient<CarMasterSocketApi>()
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = OrderViewModel(networkProvider: networkProvider, socketClient: socketClient)
        return viewModel
    }
}
