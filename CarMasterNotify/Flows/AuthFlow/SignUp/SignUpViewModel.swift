//
//  SignUpViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift

class SignUpViewModel {
    let data = BehaviorSubject<[AuthDataSource]>(value: [
        AuthDataSource(title: "", items: [.textField, .textField, .textField, .textField, .textField, .textField]),
                                                         AuthDataSource(title: "", items: [.button]),
                                                         AuthDataSource(title: "", items: [.error(error: "")])])
    let disposeBag = DisposeBag()
    let networkProvider: CustomMoyaProvider<CarMasterApi.Auth>
    let title = BehaviorSubject<String>(value: "Registration")
    let confirmTouched = PublishSubject<Void>()
    let firstName = PublishSubject<String>()
    let lastName = PublishSubject<String>()
    let phone = PublishSubject<String>()
    let email = PublishSubject<String>()
    let password = PublishSubject<String>()
    let confirmPassword = PublishSubject<String>()
    let errorMessage = PublishSubject<String>()

    var firstNameHint: Observable<String>!
    var lastNameHint: Observable<String>!
    var phoneHint: Observable<String>!
    var emailHint: Observable<String>!
    var passwordHint: Observable<String>!
    var confirmPasswordHint: Observable<String>!
    var user = UserDataModel()
    var pass: String = ""
    var validation: Observable<Bool>?

    var finishFlow: (()->())?

    init(networkProvider: CustomMoyaProvider<CarMasterApi.Auth>) {
        self.networkProvider = networkProvider
        self.setupBindings()
    }

    func setupBindings() {
        confirmTouched
            .subscribe(onNext: {[weak self] in
                if let user = self?.user, let self = self {
                    self.signUp(userDataModel: user, password: self.pass)
                }
            })
            .disposed(by: disposeBag)

        firstNameHint = firstName.asObservable()
            .do(onNext:{[weak self] name in  self?.user.firstName = name})
            .flatMapLatest {text in return Observable.just(text.validate(type: .name))}

        lastNameHint = lastName.asObservable()
            .do(onNext:{[weak self] name in  self?.user.lastName = name})
            .flatMapLatest {text in return Observable.just(text.validate(type: .name))}

        phoneHint = phone.asObservable()
            .do(onNext:{[weak self] phone in  self?.user.phone = phone})
            .flatMapLatest {text in return Observable.just(text.validate(type: .phone))}

        emailHint = email.asObservable()
            .do(onNext:{[weak self] email in  self?.user.email = email})
            .flatMapLatest {text in return Observable.just(text.validate(type: .email))}

        passwordHint = password.asObservable()
            .do(onNext: {[weak self] pass in self?.pass = pass})
            .flatMapLatest {text in return Observable.just(text.validate(type: .password))}
        
        confirmPasswordHint = Observable.combineLatest([password, confirmPassword])
            .flatMapLatest{passwords in
                return Observable.just(passwords[1].validate(type: .confirmPassword(password: passwords[0])))}

        self.validation = Observable.combineLatest([firstNameHint, lastNameHint, phoneHint, emailHint, passwordHint, confirmPasswordHint])
            .flatMapLatest{fields in
                return Observable.just(
                    fields.filter{!$0.isEmpty}.isEmpty
                )
        }
    }

    func signUp(userDataModel: UserDataModel, password: String) {
        let request = CarMasterSignUpRequest(user: userDataModel, password: password)
        networkProvider.request(.registration(request: request))
            .subscribe(onSuccess: { [weak self] _ in
                self?.signIn(login: userDataModel.email!, password: password)
            }, onError: {[weak self] error in
                print(error)
                self?.errorMessage.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    func signIn(login: String, password: String) {
        let request = CarMasterSignInRequest(login: login, password: password)
        networkProvider.request(.signIn(request: request))
        .subscribe(onSuccess: {[weak self] response in
            let tokens = try? response.map(TokenModel.self)
            if let accessToken = tokens?.accessToken, let refreshToken = tokens?.refreshToken {
                SecureManager.accessToken = accessToken
                SecureManager.refreshToken = refreshToken
                SecureManager.isAutorized = true
                self?.finishFlow!()
                }
            }, onError: {[weak self] error in
                print(error)
                self?.errorMessage.onNext(error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
}
