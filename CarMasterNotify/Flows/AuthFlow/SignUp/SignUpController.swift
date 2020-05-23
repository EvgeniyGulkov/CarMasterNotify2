//
//  SignUpController.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpController: BaseTableViewController {
    @IBOutlet weak var confirmButton: RoundedCornerButton!
    @IBOutlet weak var firstName: DefaultTextField!
    @IBOutlet weak var lastName: DefaultTextField!
    @IBOutlet weak var phone: DefaultTextField!
    @IBOutlet weak var email: DefaultTextField!
    @IBOutlet weak var password: DefaultTextField!
    @IBOutlet weak var confirmPassword: DefaultTextField!
    
    private let disposeBag = DisposeBag()
    var viewModel: SignUpViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupBindings() {
        self.firstName.rx.text
            .orEmpty
            .bind(to: self.viewModel!.firstName)
            .disposed(by: disposeBag)

        self.lastName.rx.text
            .orEmpty
            .bind(to: self.viewModel!.lastName)
            .disposed(by: disposeBag)
        
        self.phone.rx.text
            .orEmpty
            .bind(to: self.viewModel!.phone)
            .disposed(by: disposeBag)
        
        self.email.rx.text
            .orEmpty
            .bind(to: self.viewModel!.email)
            .disposed(by: disposeBag)
        
        self.password.rx.text
            .orEmpty
            .bind(to: self.viewModel!.password)
            .disposed(by: disposeBag)
        
        self.confirmPassword.rx.text
            .orEmpty
            .bind(to: self.viewModel!.confirmPassword)
            .disposed(by: disposeBag)

        self.confirmButton.rx.tap
            .map{return self.password.text!}
            .bind(to: self.viewModel!.confirmTouched)
            .disposed(by: disposeBag)

        self.viewModel?.firstNameHint
            .bind(to: self.firstName.hintLabel.rx.text)
            .disposed(by: disposeBag)

        self.viewModel?.lastNameHint
            .bind(to: self.lastName.hintLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel?.phoneHint
            .bind(to: self.phone.hintLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel?.emailHint
            .bind(to: self.email.hintLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel?.passwordHint
            .bind(to: self.password.hintLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel?.confirmPasswordHint
            .bind(to: self.confirmPassword.hintLabel.rx.text)
            .disposed(by: disposeBag)

        self.viewModel?.validation?
            .subscribe(onNext: {[weak self] result in
                self?.confirmButton.setEnabled(isEnabled: result)
            })
            .disposed(by: disposeBag)

        self.viewModel?.title
        .subscribe(onNext: {[weak self] title in
            self?.title = title
            })
        .disposed(by: disposeBag)
    }
}
