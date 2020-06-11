//
//  AuthDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class AuthDataSourceFactory {
    static func loginDataSource (viewModel: LoginViewModel) ->
        RxTableViewSectionedReloadDataSource<AuthDataSource> { return RxTableViewSectionedReloadDataSource<AuthDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch item {
                case .spacer:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.spacer,
                                                                   for: indexPath) as? SpacerTableViewCell else {
                                                                    return UITableViewCell()
                    }
                    viewModel.spacer?
                        .bind(to: cell.spacerHeight.rx.constant)
                        .disposed(by: viewModel.disposeBag)
                    return cell
                case .textField:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.textField,
                                                                   for: indexPath) as? TextFieldTableViewCell else {
                                                                    return UITableViewCell()
                    }
                    configureTextFields(cell: cell, indexPath: indexPath, viewModel: viewModel)
                    return cell
                case .button:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.button,
                                                                   for: indexPath) as? ButtonTableViewCell else {
                                                                    return UITableViewCell()
                    }
                    configureButtons(cell: cell, indexPath: indexPath, viewModel: viewModel)
                    return cell
                case .error:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.error,
                                                                   for: indexPath) as? ErrorTextTableViewCell else {
                                                                    return UITableViewCell()
                    }
                    configureErrorLabel(cell: cell, indexPath: indexPath, viewModel: viewModel)
                    return cell
                case .twoButtons:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.twoButtons,
                                                                   for: indexPath) as? TwoButtonsTableViewCell else {
                                                                    return UITableViewCell()
                    }
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

    private static func configureTextFields(cell: TextFieldTableViewCell,
                                            indexPath: IndexPath,
                                            viewModel: LoginViewModel) {
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
    }

    private static func configureButtons(cell: ButtonTableViewCell,
                                         indexPath: IndexPath,
                                         viewModel: LoginViewModel) {
        cell.button.setEnabled(isEnabled: false)
        cell.button.rx.tap
            .bind(to: viewModel.signInButton)
            .disposed(by: viewModel.disposeBag)

        viewModel.validation
            .subscribe(onNext: {
                cell.button.setEnabled(isEnabled: $0)})
            .disposed(by: viewModel.disposeBag)
    }

    private static func configureErrorLabel(cell: ErrorTextTableViewCell,
                                            indexPath: IndexPath,
                                            viewModel: LoginViewModel) {
        viewModel.errorMessage
            .bind(to: cell.errorLabel.rx.text)
            .disposed(by: viewModel.disposeBag)
    }
}
