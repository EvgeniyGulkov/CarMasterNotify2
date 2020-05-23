//
//  SelectCompanyController.swift
//  CarMasterNotify
//
//  Created by Admin on 20.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectCompanyController: BaseTableViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var spacerHeight: NSLayoutConstraint!

    var viewModel: SelectCompanyViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    func setupUI() {
        spacerHeight.constant = self.view.frame.height*0.25
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesBackButton = true
    }

    func setupBindings() {
        self.viewModel?.title
            .subscribe(onSuccess: {[weak self] title in
                self?.title = title
                }, onError: {_ in print("Cannot get title")})
            .disposed(by: disposeBag)
        
        self.navigationItem.leftBarButtonItem?.rx.tap
            .bind(to: self.viewModel.backButtonTouched)
            .disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.finishFlow!()
    }
}
