import UIKit
import RxSwift

class NameChangeViewModel {
    let disposeBag = DisposeBag()
    var tapCancel: PublishSubject<Void>
    var tapDone: PublishSubject<String>
    
    var userName: Observable<String>?
    var nameChanged: PublishSubject<Void>
    
    init() {
        self.userName = Observable.just(UserDefaults.standard.string(forKey: "shortName") ?? "")
        
        self.tapCancel = PublishSubject<Void>()
        self.tapDone = PublishSubject<String>()
        self.nameChanged = PublishSubject()
        
        self.tapDone.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {self.changeName(newName: $0)})
            .disposed(by: disposeBag)
    }
    
    func changeName(newName: String) {
        UserDefaults.standard.set(newName, forKey: "shortName")
        self.nameChanged.onNext(())
    }
}
