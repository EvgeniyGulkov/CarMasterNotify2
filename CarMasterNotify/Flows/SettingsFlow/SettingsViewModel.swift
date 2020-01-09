import Foundation
import RxSwift

class SettingsViewModel {
    let disposeBag = DisposeBag()
    let selectSettings:PublishSubject<IndexPath>
    var user: Observable<String>?
    var title: Observable<String>?
    var viewWillAppear: PublishSubject<Void>
    
    var showPasswordChangeDialogue:(()->())?
    var showNameChangeDialogue:((String)->())?
    
    init(username: String = SettingsHelper.userName) {
        self.viewWillAppear = PublishSubject()
        self.selectSettings = PublishSubject()
        
        self.user = self.viewWillAppear.asObservable()
            .map{return username}
            
        self.selectSettings.asObservable()
            .subscribe(onNext: {indexpath in
                if indexpath.section == 0 {
                    switch indexpath.row {
                    case 0: self.showNameChangeDialogue!(username)
                    case 1: self.showPasswordChangeDialogue!()
                    default: break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
