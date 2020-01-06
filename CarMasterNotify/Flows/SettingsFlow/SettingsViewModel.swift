import Foundation
import RxSwift

class SettingsViewModel {
    let disposeBag = DisposeBag()
    let selectSettings:PublishSubject<IndexPath>
    var userName: Observable<String>?
    var title: Observable<String>?
    var viewWillAppear: PublishSubject<Void>
    
    var showPasswordChangeDialogue:(()->())?
    var showNameChangeDialogue:(()->())?
    
    init() {
        self.viewWillAppear = PublishSubject()
        self.selectSettings = PublishSubject()
        
        self.userName = self.viewWillAppear.asObservable()
            .map{return UserDefaults.standard.string(forKey: "shortName") ?? ""}
            
        self.selectSettings.asObservable()
            .subscribe(onNext: {indexpath in
                if indexpath.section == 0 {
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
