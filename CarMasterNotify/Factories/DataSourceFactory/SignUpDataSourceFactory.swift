//
//  SignUpDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SignUpDataSourceFactory {
    static func signUpDataSource (viewModel: SignUpViewModel) ->
        RxTableViewSectionedReloadDataSource<AuthDataSource> { return RxTableViewSectionedReloadDataSource<AuthDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch item {
                case .textField:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.textField, for: indexPath) as! TextFieldTableViewCell
                    if indexPath.row == 0 {
                        viewModel.firstNameHint
                            .bind(to: cell.textField.hintLabel.rx.text)
                            .disposed(by: viewModel.disposeBag)
                        cell.textField.placeholder = "First Name"
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.firstName)
                            .disposed(by: viewModel.disposeBag)
                    }
                    if indexPath.row == 1 {
                        viewModel.lastNameHint
                            .bind(to: cell.textField.hintLabel.rx.text)
                            .disposed(by: viewModel.disposeBag)
                        cell.textField.placeholder = "Last Name"
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.lastName)
                            .disposed(by: viewModel.disposeBag)
                    }
                    if indexPath.row == 2 {
                        viewModel.phoneHint
                            .bind(to: cell.textField.hintLabel.rx.text)
                            .disposed(by: viewModel.disposeBag)
                        cell.textField.placeholder = "Phone"
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.phone)
                            .disposed(by: viewModel.disposeBag)
                    }
                    if indexPath.row == 3 {
                        viewModel.emailHint
                            .bind(to: cell.textField.hintLabel.rx.text)
                            .disposed(by: viewModel.disposeBag)
                        cell.textField.placeholder = "Email"
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.email)
                            .disposed(by: viewModel.disposeBag)
                    }
                    if indexPath.row == 4 {
                        viewModel.passwordHint
                            .bind(to: cell.textField.hintLabel.rx.text)
                            .disposed(by: viewModel.disposeBag)
                        cell.textField.placeholder = "Password"
                        cell.textField.isSecureTextEntry = true
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.password)
                            .disposed(by: viewModel.disposeBag)
                    }
                    if indexPath.row == 5 {
                        viewModel.confirmPasswordHint
                            .bind(to: cell.textField.hintLabel.rx.text)
                            .disposed(by: viewModel.disposeBag)
                        cell.textField.placeholder = "Confirm Password"
                        cell.textField.isSecureTextEntry = true
                        cell.textField.rx.text
                            .orEmpty
                            .bind(to: viewModel.confirmPassword)
                            .disposed(by: viewModel.disposeBag)
                    }
                    return cell
                case .button:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.button, for: indexPath) as! ButtonTableViewCell
                    cell.button.setEnabled(isEnabled: false)
                    
                    cell.button.rx.tap
                        .bind(to: viewModel.confirmTouched)
                        .disposed(by: viewModel.disposeBag)
                    
                    viewModel.validation?
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
                default: return UITableViewCell()
                }
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }
}
