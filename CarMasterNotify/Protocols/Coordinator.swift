//
//  Coordinator.swift
//  CarMasterNotify
//
//  Created by Admin on 12/10/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

protocol Coordinator:class {
    func start()
    func start(with option: DeepLinkOption?)
}
