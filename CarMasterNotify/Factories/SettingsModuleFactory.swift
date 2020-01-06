import UIKit

protocol SettingsModuleFactory {
    func makeSettingsOutput(viewModel: SettingsViewModel) -> SettingsController
    
    func makeChangePasswordDialogueOutput(viewModel: PasswordDialogueViewModel) -> PasswordDialogueController
    
    func makeChangeNameDialogueOutput(viewModel: NameChangeViewModel) -> NameChangeDialogueController
}
