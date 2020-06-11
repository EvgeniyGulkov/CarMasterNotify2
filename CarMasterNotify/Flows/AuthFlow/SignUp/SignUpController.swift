//
//  SignUpController.swift
//  CarMasterNotify
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

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
    var viewModel: SignUpViewModel!

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
        self.viewModel.data
            .bind(to: self.tableView.rx.items(dataSource: SignUpDataSourceFactory.signUpDataSource(viewModel: viewModel)))
            .disposed(by: disposeBag)

        self.viewModel?.title
        .subscribe(onNext: {[weak self] title in
            self?.title = title
            })
        .disposed(by: disposeBag)
    }
}
