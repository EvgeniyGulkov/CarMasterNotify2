//
//  ReasonViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift

class DetailsViewModel {
    let order: Order
    let networkProvider: CustomMoyaProvider<CarMasterApi>
    private let disposeBag = DisposeBag()
    
    var reasonsViewModels: [DetailsCellViewModel] = []
    
    var reasons: PublishSubject<[DetailsDataSource]>
    
    init(order: Order, networkProvider: CustomMoyaProvider<CarMasterApi>) {
        self.order = order
        self.reasons = PublishSubject()
        self.networkProvider = networkProvider
    }
    
    func getReasons () {
        self.networkProvider.request(.getReasons(orderNumber: Int(self.order.number)))
        .subscribe(onSuccess: { reasons in
         //   let _ = reasons.map {$0.toManagedObject(order: self.order)}
            DataController.shared.save()
            self.updateReasons()
        }, onError: {error in
            print(error)
            self.updateReasons()
        })
        .disposed(by: self.disposeBag)
    }
    
    private func updateReasons() {
        guard let reasons = order.reason?.allObjects else {return}
        self.reasonsViewModels.removeAll()
        let orders: [Order] = Array(repeating: order, count: reasons.count)
        self.reasons.onNext([DetailsDataSource(title: "Car information", items: [order]), DetailsDataSource(title: "Reasons", items: orders)])
       }
    
    private func createReasonsCellViewModels(reasons: [Reason]) {
        self.reasonsViewModels.removeAll()
        for reason in reasons {
            self.reasonsViewModels.append(DetailsCellViewModel(id:reason.id! ,status: .error))
        }
    }
}
