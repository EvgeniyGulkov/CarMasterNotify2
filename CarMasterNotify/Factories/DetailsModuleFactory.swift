//
//  ReasonsModuleFactory.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol DetailsModuleFactory {
    func makeMessagesOutput(viewModel: MessageViewModel) -> MessageController
}
