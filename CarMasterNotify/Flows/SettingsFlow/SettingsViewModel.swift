import Foundation
import RxSwift

class SettingsViewModel {
    private let disposeBag = DisposeBag()
    let selectSettings: PublishSubject<IndexPath>
    let signOutButton: PublishSubject<Void>
    let nickName: Single<String>
    let position: Single<String>
    let fullName: Single<String>
    let accessLevel: Single<String>
    let viewWillAppear: PublishSubject<Void>

    var showPasswordChangeDialogue:(() -> Void)?
    var showNameChangeDialogue:(() -> Void)?
    
    init() {
        let user = User.currentUser
        let firstName = user?.firstName ?? ""
        let lastName = user?.lastName ?? ""
        let position = user?.position ?? ""
        self.accessLevel = Single.just(SecureManager.accessLevel.string)
        self.nickName = Single.just(user?.nickName ?? firstName)
        self.fullName = Single.just("\(firstName) \(lastName)")
        self.position = Single.just(position)
        self.viewWillAppear = PublishSubject()
        self.selectSettings = PublishSubject()
        self.signOutButton = PublishSubject()
            
        self.selectSettings.asObservable()
            .subscribe(onNext: { indexpath in
                if indexpath.section == 1 {
                    switch indexpath.row {
                    case 0: self.showNameChangeDialogue!()
                    case 2: self.showPasswordChangeDialogue!()
                    default: break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
