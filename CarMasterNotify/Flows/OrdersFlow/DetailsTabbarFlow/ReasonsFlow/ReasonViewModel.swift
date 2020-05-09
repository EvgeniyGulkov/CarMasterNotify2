//
//  ReasonViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift

class ReasonViewModel {
    let order: Order
    let networkProvider: CustomMoyaProvider<CarMasterApi>
    private let disposeBag = DisposeBag()
    
    var reasonsViewModels: [ReasonsCellViewModel] = []
    var title: Observable<String>
    
    var reasons: PublishSubject<[ReasonDataSource]>
    
    init(order: Order, networkProvider: CustomMoyaProvider<CarMasterApi>) {
        self.order = order
        
        self.title = Observable.just("\(order.manufacturer!) \(order.model!) - \(order.plateNumber!)")
        
        self.reasons = PublishSubject()
        
        self.networkProvider = networkProvider
    }
    
    func getReasons () {
        self.networkProvider.request(.getReasons(orderNumber: Int(self.order.number)), [ReasonModel].self)
        .subscribe(onSuccess: { reasons in
            let _ = reasons.map {$0.toManagedObject(order: self.order)}
            CoreDataManager.save()
            self.updateReasons()
        }, onError: {error in
            print(error)
            self.updateReasons()
        })
        .disposed(by: self.disposeBag)
    }
    
    private func updateReasons() {
           let reasons = self.order.reason?.allObjects as! [Reason]
           self.createReasonsCellViewModels(reasons: reasons)
           self.reasons.onNext([ReasonDataSource(items: reasons)])
       }
    
    private func createReasonsCellViewModels(reasons: [Reason]) {
        self.reasonsViewModels.removeAll()
        for reason in reasons {
            self.reasonsViewModels.append(ReasonsCellViewModel(id:reason.id! ,status: .error))
        }
    }
}
