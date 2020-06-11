//
//  SignUpDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Gulkov on 23.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class SignUpDataSourceFactory {
    static func signUpDataSource (viewModel: SignUpViewModel) ->
        RxTableViewSectionedReloadDataSource<AuthDataSource> { return RxTableViewSectionedReloadDataSource<AuthDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch item {
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
                default: return UITableViewCell()
                }
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }

    private static func configureTextFields(cell: TextFieldTableViewCell, indexPath: IndexPath, viewModel: SignUpViewModel) {
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
    }

    private static func configureButtons(cell: ButtonTableViewCell, indexPath: IndexPath, viewModel: SignUpViewModel) {
        cell.button.setEnabled(isEnabled: false)
        cell.button.rx.tap
            .bind(to: viewModel.confirmTouched)
            .disposed(by: viewModel.disposeBag)

        viewModel.validation?
            .subscribe(onNext: {
                cell.button.setEnabled(isEnabled: $0)})
            .disposed(by: viewModel.disposeBag)
    }

    private static func configureErrorLabel(cell: ErrorTextTableViewCell, indexPath: IndexPath, viewModel: SignUpViewModel) {
        viewModel.errorMessage
        .bind(to: cell.errorLabel.rx.text)
        .disposed(by: viewModel.disposeBag)
    }
}
