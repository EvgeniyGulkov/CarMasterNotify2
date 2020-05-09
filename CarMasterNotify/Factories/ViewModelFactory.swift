import UIKit
import SocketIO

class ViewModelFactory {
    
    static func makeDetailViewModel(order: Order,socketClient: SocketClient<CarMasterSocketApi>) -> DetailViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        return DetailViewModel(order: order, networkProvider: networkProvider, socketClient: socketClient)
    }
    
    static func makeReasonViewModel(order: Order) -> ReasonViewModel {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        return ReasonViewModel(order: order, networkProvider: networkProvider)
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
    
    static func makeNameDialogueViewModel(username: String) -> NameChangeViewModel {
        let viewModel = NameChangeViewModel(username: username)
        return viewModel
    }
    
    static func makeOrderViewModel() -> OrderViewModel {
        let socketClient = SocketClient<CarMasterSocketApi>()
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        let viewModel = OrderViewModel(networkProvider: networkProvider, socketClient: socketClient)
        return viewModel
    }
}
