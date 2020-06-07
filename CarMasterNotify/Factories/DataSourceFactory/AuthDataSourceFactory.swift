//
//  AuthDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class AuthDataSourceFactory {
    static func loginDataSource (viewModel: LoginViewModel) ->
        RxTableViewSectionedReloadDataSource<AuthDataSource> { return RxTableViewSectionedReloadDataSource<AuthDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch item {
                case .spacer:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.spacer, for: indexPath) as! SpacerTableViewCell
                    viewModel.spacer?
                        .bind(to: cell.spacerHeight.rx.constant)
                        .disposed(by: viewModel.disposeBag)
                    return cell
                case .textField:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.textField, for: indexPath) as! TextFieldTableViewCell
                    if indexPath.row == 0 {
                        cell.textField.placeholder = "Phone or Email"
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.loginText)
                            .disposed(by: viewModel.disposeBag)
                    }
                    if indexPath.row == 1 {
                        cell.textField.placeholder = "Password"
                        cell.textField.isSecureTextEntry = true
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.passwordText)
                            .disposed(by: viewModel.disposeBag)
                    }
                    return cell
                case .button:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.button, for: indexPath) as! ButtonTableViewCell
                    cell.button.setEnabled(isEnabled: false)
                    
                    cell.button.rx.tap
                        .bind(to: viewModel.signInButton)
                        .disposed(by: viewModel.disposeBag)
                    
                    viewModel.validation
                        .subscribe(onNext: {
                            cell.button.setEnabled(isEnabled: $0)})
                        .disposed(by: viewModel.disposeBag)
                    return cell
                case .error:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.error, for: indexPath) as! ErrorTextTableViewCell
                    viewModel.errorMessage
                        .bind(to: cell.errorLabel.rx.text)
                        .disposed(by: viewModel.disposeBag)
                    return cell
                case .twoButtons:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.twoButtons, for: indexPath) as! TwoButtonsTableViewCell
                    cell.leftButton.setTitle("Forgot password", for: [])
                    cell.rightButton.setTitle("Sign Up", for: [])
                    cell.rightButton.rx.tap
                        .bind(to: viewModel.sighUpButton)
                        .disposed(by: viewModel.disposeBag)
                    return cell
                }
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }
}
