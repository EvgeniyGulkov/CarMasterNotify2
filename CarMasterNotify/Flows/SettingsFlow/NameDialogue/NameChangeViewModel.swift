import RxSwift

class NameChangeViewModel {
    let disposeBag = DisposeBag()
    var tapCancel: PublishSubject<Void>
    var tapDone: PublishSubject<String>
    var userName: Observable<String>?
    var nameChanged: PublishSubject<Void>

    init() {
        let nickName = User.currentUser?.nickName ?? ""
        self.userName = Observable.just(nickName)
        self.tapCancel = PublishSubject<Void>()
        self.tapDone = PublishSubject<String>()
        self.nameChanged = PublishSubject()

        self.tapDone.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {self.changeName(newName: $0)})
            .disposed(by: disposeBag)

    }

    func changeName(newName: String) {
        let provider = CustomMoyaProvider<CarMasterApi.User>()
        let request = CarMasterChangeNicknameRequest(newNickname: newName)
        provider.request(.changeChatname(request: request))
            .subscribe(onSuccess: { result in
                print(result)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)

        self.nameChanged.onNext(())
    }
}
