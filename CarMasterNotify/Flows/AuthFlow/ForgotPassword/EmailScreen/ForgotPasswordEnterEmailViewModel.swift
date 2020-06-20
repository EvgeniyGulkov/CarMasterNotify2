//
//  ForgotPasswordViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 14.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift

class ForgotPasswordEnterEmailViewModel {
    private let disposeBag = DisposeBag()

    var emailText = PublishSubject<String>()
    var okButtonPressed = PublishSubject<Void>()
    var closeButtonPressed = PublishSubject<Void>()
    var networkProvider: CustomMoyaProvider<CarMasterApi>
    var finishFlow: (() -> Void)?
    var showEnterCodeScreen: (() -> Void)?

    init(networkProvider: CustomMoyaProvider<CarMasterApi>) {
        self.networkProvider = networkProvider
        okButtonPressed.subscribe(onNext: { [weak self] in
            self?.showEnterCodeScreen!()
        })
        .disposed(by: disposeBag)
        closeButtonPressed.subscribe(onNext: { [weak self] in
            self?.finishFlow!()
        })
        .disposed(by: disposeBag)
    }
}
