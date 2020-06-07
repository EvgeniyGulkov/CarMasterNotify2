//
//  UsersDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class UsersDataSourcesFactory {
    static func usersDataSource () ->
        RxTableViewSectionedReloadDataSource<UsersDataSource> { return RxTableViewSectionedReloadDataSource<UsersDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.user, for: indexPath) as! UserTableViewCell
                if let firstName = item.firstName, let lastName = item.lastName,
                    let position = item.position, let accessLevel = item.accessLevel {
                    cell.accessLevel.text = accessLevel
                    cell.userFullName.text = "\(firstName) \(lastName)"
                    cell.userPosition.text = position
                }
                return cell
                
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }
}
