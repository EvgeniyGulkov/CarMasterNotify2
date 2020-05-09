import Foundation
import RxSwift

class SettingsViewModel {
    private let disposeBag = DisposeBag()
    let selectSettings: PublishSubject<IndexPath>
    let signOutButton: PublishSubject<Void>
    var user: Observable<String>?
    var title: Observable<String>?
    var viewWillAppear: PublishSubject<Void>
    
    var showPasswordChangeDialogue:(()->())?
    var showNameChangeDialogue:((String)->())?
    
    init() {
        let settingsHelper = SettingsHelper()
        let chatName = settingsHelper.fetchRequest(key: .chatName, type: String.self) ?? ""
        
        self.viewWillAppear = PublishSubject()
        self.selectSettings = PublishSubject()
        self.signOutButton = PublishSubject()
        
        self.user = self.viewWillAppear.asObservable()
            .map{return chatName}
            
        self.selectSettings.asObservable()
            .subscribe(onNext: {indexpath in
                if indexpath.section == 0 {
                    switch indexpath.row {
                    case 0: self.showNameChangeDialogue!(chatName)
                    case 1: self.showPasswordChangeDialogue!()
                    default: break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
