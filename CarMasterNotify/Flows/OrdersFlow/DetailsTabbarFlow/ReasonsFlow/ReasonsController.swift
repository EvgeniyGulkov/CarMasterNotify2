//
//  ReasonsController.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReasonsController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: ReasonViewModel!
    var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        self.refreshControl = UIRefreshControl()
        self.refresh()
    }
    
    func setupBindings() {
        self.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.refresh()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.title
            .bind(to: self.rx.title)
            .disposed(by: self.disposeBag)
        
        self.viewModel.reasons
            .bind(to: self.tableView.rx.items(dataSource: DataSourcesFactory
                .reasonsDatasource(viewModel: self.viewModel)))
            .disposed(by: self.disposeBag)
    }
    
    func refresh() {
        self.viewModel.getReasons()
    }
}
