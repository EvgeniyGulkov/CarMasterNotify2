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

class DetailsController: BaseTableViewController {
    private let disposeBag = DisposeBag()
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        self.tableView.dataSource = nil
        self.refreshControl = UIRefreshControl()
        self.refresh()
    }
    
    func setupBindings() {
        self.refreshControl!.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.refresh()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.reasons
            .do(onNext: { [weak self] _ in self?.refreshControl?.endRefreshing()})
            .bind(to: self.tableView.rx.items(dataSource: DataSourcesFactory
                .reasonsDatasource(viewModel: self.viewModel)))
            .disposed(by: self.disposeBag)
    }
    
    func refresh() {
        self.viewModel.getReasons()
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = Theme.Color.blueColor
    }
}
