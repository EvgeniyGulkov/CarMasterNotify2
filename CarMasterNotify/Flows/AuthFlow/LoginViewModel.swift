import Foundation
import RxSwift
import KeychainAccess

class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    let loginText: PublishSubject<String>
    let passwordText: PublishSubject<String>
    let signInButton: PublishSubject<CarMasterApi>
    let loading: PublishSubject<Bool>
    let errorMessage: PublishSubject<String>
    
    var checkFields: Observable<Bool>
    var networkProvider: NetworkProvider
    
    var signInOk: (()->())?
    
    init(networkProvider: NetworkProvider) {
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
            .subscribe(onNext: {[unowned self] signIn in
                self.loading.onNext(true)
                let tokens = self.networkProvider.request(from: signIn, Int.self)
                tokens.subscribe(
                    onSuccess: {statusCode in
                        self.loading.onNext(false)
                        
                        if statusCode == 200 {
                            self.signInOk!()
                        }
                        if statusCode == 403 {
                            self.errorMessage.onNext("Login or password is incorrect")
                        }
                },
                    onError: {error in
                        self.errorMessage.onNext(error.localizedDescription)
                        self.loading.onNext(false)
                })
                    .disposed(by: self.disposeBag)
            })
        .disposed(by: disposeBag)
    }
}
