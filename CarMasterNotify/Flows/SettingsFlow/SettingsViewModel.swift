import RxSwift

class SettingsViewModel {
    private let disposeBag = DisposeBag()
    let selectSettings: PublishSubject<IndexPath> = PublishSubject()
    let signOutButton: PublishSubject<Void> = PublishSubject()
    let accessLevel: PublishSubject<String> = PublishSubject()
    let viewWillAppear: PublishSubject<Void> = PublishSubject()
    let nickName: Single<String>
    let position: Single<String>
    let fullName: Single<String>

    var showPasswordChangeDialogue:(() -> Void)?
    var showNameChangeDialogue:(() -> Void)?

    init() {
        let user = User.currentUser
        let firstName = user?.firstName ?? ""
        let lastName = user?.lastName ?? ""
        let position = user?.position ?? ""
        self.nickName = Single.just(user?.nickName ?? firstName)
        self.fullName = Single.just("\(firstName) \(lastName)")
        self.position = Single.just(position)

        SecureManager.accessLevel.subscribe(onNext: {[weak self] access in
            self?.accessLevel.onNext(access.string)
            })
            .disposed(by: disposeBag)

        self.selectSettings.asObservable()
            .subscribe(onNext: { indexpath in
                if indexpath.section == 1 {
                    switch indexpath.row {
                    case 0: self.showNameChangeDialogue!()
                    case 1: self.showPasswordChangeDialogue!()
                    default: break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
