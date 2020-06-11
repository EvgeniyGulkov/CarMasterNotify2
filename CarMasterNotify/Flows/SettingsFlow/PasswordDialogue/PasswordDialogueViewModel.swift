import RxSwift

class PasswordDialogueViewModel {
    let disposeBag = DisposeBag()
    var tapCancel: PublishSubject<Void>
    var tapDone: PublishSubject<Void>
    var passwordChanged: PublishSubject<Void>

    init() {
        self.passwordChanged = PublishSubject<Void>()
        self.tapCancel = PublishSubject<Void>()
        self.tapDone = PublishSubject<Void>()
        self.tapDone.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {self.changePassword()})
            .disposed(by: disposeBag)
    }

    func changePassword() {
        print("passwordChanged")
        passwordChanged.onNext(())
    }
}
