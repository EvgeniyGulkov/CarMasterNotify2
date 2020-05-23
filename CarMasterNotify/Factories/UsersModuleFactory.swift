import UIKit

protocol UsersModuleFactory {
    func makeUsersOutput(viewModel: UsersViewModel) -> UsersController
}
