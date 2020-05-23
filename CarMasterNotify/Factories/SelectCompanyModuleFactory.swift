//
//  SelectCompanyFlow.swift
//  CarMasterNotify
//
//  Created by Admin on 21.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol SelectCompanyModuleFactory {
    func makeSelectCompanyOutput(viewModel: SelectCompanyViewModel) -> SelectCompanyController
  //  func makeSignUpOutput(viewModel: SignUpViewModel) -> SignUpController
}
