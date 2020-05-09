//
//  ReasonsModuleFactory.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol DetailsModuleFactory {
    func makeDetailsTabbarOutput() -> DetailsTabbarController
    func makeReasonsOutput(viewModel: ReasonViewModel) -> ReasonsController
    func makeMessagesOutput(viewModel: MessageViewModel) -> MessageController
}
