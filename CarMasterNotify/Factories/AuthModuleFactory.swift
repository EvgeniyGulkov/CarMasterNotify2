protocol AuthModuleFactory {
    func makeLoginOutput(viewModel: LoginViewModel) -> LoginController
    func makeSignUpOutput(viewModel: SignUpViewModel) -> SignUpController
}
