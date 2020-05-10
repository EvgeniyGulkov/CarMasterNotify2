import Foundation
import RxSwift

class SettingsViewModel {
    private let disposeBag = DisposeBag()
    var selectSettings: PublishSubject<IndexPath>?
    var signOutButton: PublishSubject<Void>?
    var nickName: Single<String>?
    var position: Single<String>?
    var fullName: Single<String>?
    var accessLevel: Single<String>?
    var title: Observable<String>?
    var viewWillAppear: PublishSubject<Void>?

    var showPasswordChangeDialogue:(()->())?
    var showNameChangeDialogue:((String)->())?
    
    init() {
        guard let user = User.currentUser,
            let firstName = user.firstName,
            let lastName = user.lastName,
            let position = user.position else {
            return
        }
        self.accessLevel = Single.just(SecureManager.accessLevel.string)
        self.nickName = Single.just(user.nickName ?? firstName)
        self.fullName = Single.just("\(firstName) \(lastName)")
        self.position = Single.just(position)
        self.viewWillAppear = PublishSubject()
        self.selectSettings = PublishSubject()
        self.signOutButton = PublishSubject()
            
        self.selectSettings?.asObservable()
            .subscribe(onNext: {indexpath in
                if indexpath.section == 1 {
                    switch indexpath.row {
                   // case 0: self.showNameChangeDialogue!(chatName)
                    case 2: self.showPasswordChangeDialogue!()
                    default: break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
