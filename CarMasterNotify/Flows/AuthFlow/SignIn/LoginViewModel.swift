import Foundation
import RxSwift
import KeychainAccess

class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    let loginText: PublishSubject<String> = PublishSubject()
    let passwordText = PublishSubject<String>()
    let signInButton = PublishSubject<CarMasterSignInRequest>()
   // let loading: PublishSubject<Bool> = PublishSubject()
    let errorMessage = BehaviorSubject<String>(value: "")
    let sighUpButton: PublishSubject<Void> = PublishSubject()
    let forgotPasswordButton: PublishSubject<Void> = PublishSubject()
    var checkFields: Observable<Bool>
    var networkProvider: CustomMoyaProvider<CarMasterApi.Auth>

    var signInOk: (() -> Void)?
    var forgotPassword: (() -> Void)?
    var signUp: (() -> Void)?
    
    init(networkProvider: CustomMoyaProvider<CarMasterApi.Auth>) {
        self.networkProvider = networkProvider
        
        self.checkFields = Observable.combineLatest(self.loginText.asObservable(),self.passwordText.asObservable())
            .observeOn(MainScheduler.instance)
            .map{arg -> Bool in
                let (login,password) = arg
                return !login.isEmpty && !password.isEmpty
        }
        
        self.signInButton.asObservable()
            .subscribe(onNext: {[weak self] signIn in
                self?.signIn(signIn)
            })
        .disposed(by: disposeBag)

        self.sighUpButton.asObservable()
            .subscribe(onNext: {[weak self] in
                self?.signUp!()
            })
        .disposed(by: disposeBag)
    }
    
    func signIn (_ request: CarMasterSignInRequest) {
        networkProvider.request(.signIn(request: request))
            .subscribe(
            onSuccess: { [weak self] response in
                let tokens = try? response.map(TokenModel.self)
                if let accessToken = tokens?.accessToken, let refreshToken = tokens?.refreshToken {
                    SecureManager.accessToken = accessToken
                    SecureManager.refreshToken = refreshToken
                    SecureManager.isAutorized = true
                    self?.signInOk!()
                }
        },
            onError: { [weak self] error in
                print(error.localizedDescription)
                self?.errorMessage.onNext(error.localizedDescription)
        })
            .disposed(by: self.disposeBag)
    }
}
