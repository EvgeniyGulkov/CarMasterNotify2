import RxSwift
import KeychainAccess

class LoginViewModel {
    let data = BehaviorSubject<[AuthDataSource]>(value: [AuthDataSource(title: "", items: [.spacer]),
                                                         AuthDataSource(title: "", items: [.textField, .textField]),
                                                         AuthDataSource(title: "", items: [.twoButtons]),
                                                         AuthDataSource(title: "", items: [.button]),
                                                         AuthDataSource(title: "", items: [.error(error: "")])])

    let disposeBag = DisposeBag()
    let loginText: PublishSubject<String> = PublishSubject()
    let passwordText = PublishSubject<String>()
    let signInButton = PublishSubject<Void>()
    let sighUpButton: PublishSubject<Void> = PublishSubject()
    let forgotPasswordButton: PublishSubject<Void> = PublishSubject()
    var spacer: Observable<CGFloat>?
    let errorMessage = PublishSubject<String>()

    var validation: Observable<Bool>!
    var networkProvider: CustomMoyaProvider<CarMasterApi.Auth>
    var login: String = ""
    var password: String = ""
    var finishFlow: (() -> Void)?
    var showForgotPassword: (() -> Void)?
    var signUp: (() -> Void)?

    init(networkProvider: CustomMoyaProvider<CarMasterApi.Auth>) {
        self.networkProvider = networkProvider

        self.validation = Observable.combineLatest([loginText, passwordText])
            .do(onNext: {self.login = $0[0]; self.password = $0[1]})
            .flatMapLatest {fields in
                return Observable.just(
                    fields.filter {$0.isEmpty}.isEmpty
                )
        }
        self.signInButton
            .subscribe(onNext: {[weak self] in
                guard let self = self else {return}
                self.signIn(login: self.login, password: self.password)})
            .disposed(by: disposeBag)

        self.sighUpButton
            .subscribe(onNext: {[weak self] in
                self?.signUp!()
            })
            .disposed(by: disposeBag)
        self.forgotPasswordButton
            .subscribe(onNext: {[weak self] in
                self?.showForgotPassword!()
            })
            .disposed(by: disposeBag)
    }

    func signIn(login: String, password: String) {
        let request = CarMasterSignInRequest(login: login, password: password)
        networkProvider.request(.signIn(request: request))
        .subscribe(onSuccess: {[weak self] response in
            let tokens = try? response.map(TokenModel.self)
            if let accessToken = tokens?.accessToken, let refreshToken = tokens?.refreshToken {
                SecureManager.accessToken = accessToken
                SecureManager.refreshToken = refreshToken
                SecureManager.isAutorized = true
                self?.getUserInfo()
                self?.finishFlow!()
                }
            }, onError: {[weak self] error in
                self?.errorMessage.onNext(error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }

    func getUserInfo() {
        CustomMoyaProvider<CarMasterApi.User>()
        .request(.info)
        .subscribe(onSuccess: { response in
            print(response)
        }, onError: { [weak self] error in
            self?.errorMessage.onNext(error.localizedDescription)
            print(error)
        })
        .disposed(by: disposeBag)
    }
}
