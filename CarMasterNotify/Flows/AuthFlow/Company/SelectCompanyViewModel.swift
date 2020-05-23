//
//  SelectCompanyViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 20.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift

class SelectCompanyViewModel {
    let title: Single<String> = Single.just("Select Company")
    private let disposeBag = DisposeBag()
    var networkProvider: CustomMoyaProvider<CarMasterApi>
    var backButtonTouched = PublishSubject<Void>()
    var finishFlow: (() -> Void)?

    init(networkProvider: CustomMoyaProvider<CarMasterApi>) {
        self.networkProvider = networkProvider
        backButtonTouched.subscribe(onNext: {[weak self] in
            if let finishFlow = self?.finishFlow {
                finishFlow()
            }
        })
        .disposed(by: disposeBag)
    }
}
