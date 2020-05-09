//
//  DetailsTabbarController.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsTabbarController: UITabBarController, UITabBarControllerDelegate {
    
    var segment: UISegmentedControl?
    
    private let firstSegment = "Reasons"
    private let secondSegment = "Comments"
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI(){
        segment = UISegmentedControl(items: [firstSegment, secondSegment])
        segment!.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
    }
    
    func setupBindings() {
        self.segment?.rx.selectedSegmentIndex
            .subscribe(onNext: {
                self.selectedIndex = $0 })
            .disposed(by: self.disposeBag)
    }
}
