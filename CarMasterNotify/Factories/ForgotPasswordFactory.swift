//
//  ForgotPasswordFactory.swift
//  CarMasterNotify
//
//  Created by Admin on 14.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol ForgotPasswordFactory {
    func makeEnterEmailOutput(viewModel: ForgotPasswordEnterEmailViewModel) -> ForgotPasswordEnterEmailController
    func makeSendCodeOutput(viewModel: ForgotPasswordEnterEmailViewModel) -> ForgotPasswordEnterEmailController
}
