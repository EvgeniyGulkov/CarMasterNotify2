import Foundation
import RxSwift
import KeychainAccess

class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    let loginText: PublishSubject<String>
    let passwordText: PublishSubject<String>
    let signInButton: PublishSubject<CarMasterSignInRequest>
    let loading: PublishSubject<Bool>
    let errorMessage: PublishSubject<String>
    
    var checkFields: Observable<Bool>
    var networkProvider: CustomMoyaProvider<CarMasterApi>
    
    var signInOk: (()->())?
    
    init(networkProvider: CustomMoyaProvider<CarMasterApi>) {
        self.networkProvider = networkProvider
        self.loginText = PublishSubject()
        self.passwordText = PublishSubject()
        self.signInButton = PublishSubject()
        self.loading = PublishSubject()
        self.errorMessage = PublishSubject()
            
        
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
    }
    
    func signIn (_ request: CarMasterSignInRequest) {
        self.loading.onNext(true)
        let provider = CustomMoyaProvider<CarMasterApi.Auth>()
        provider.signInRequest(request: request)
            .subscribe(
            onSuccess: {
                statusCode in
                self.loading.onNext(false)
                if statusCode == 200 {self.signInOk!()}
                if statusCode == 403 {self.errorMessage.onNext("Login or password is Incorrect")}
        },
            onError: {error in
                self.errorMessage.onNext(error.localizedDescription)
                self.loading.onNext(false)
        })
            .disposed(by: self.disposeBag)
    }
}
