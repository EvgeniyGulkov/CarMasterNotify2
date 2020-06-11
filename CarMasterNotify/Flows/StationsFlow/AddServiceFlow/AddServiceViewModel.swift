//
//  SelectCompanyViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 20.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift

class AddStationViewModel {
    let title: Single<String> = Single.just("Add Station")
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
