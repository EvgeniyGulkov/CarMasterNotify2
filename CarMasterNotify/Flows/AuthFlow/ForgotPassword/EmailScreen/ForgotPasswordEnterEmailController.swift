//
//  ForgotPasswordEnterEmailController.swift
//  CarMasterNotify
//
//  Created by Admin on 14.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift
import RxCocoa

class ForgotPasswordEnterEmailController: BaseTableViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var spacerHeight: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: DefaultTextField!
    @IBOutlet weak var okButton: RoundedCornerButton!

    var viewModel: ForgotPasswordEnterEmailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: nil)
        self.tableView.keyboardDismissMode = .interactive
        self.tableView.dataSource = self
    }

    func setupBindings() {
        self.okButton.rx.tap
            .bind(to: self.viewModel!.okButtonPressed)
            .disposed(by: disposeBag)
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind(to: self.viewModel!.closeButtonPressed)
            .disposed(by: disposeBag)
    }
}
