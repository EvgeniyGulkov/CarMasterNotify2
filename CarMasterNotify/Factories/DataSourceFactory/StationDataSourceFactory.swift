//
//  StationDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class StationDataSourceFactory {
    static func stationDataSource (viewModel: StationsViewModel) ->
        RxTableViewSectionedReloadDataSource<StationDataSource> { return RxTableViewSectionedReloadDataSource<StationDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.Station, for: indexPath) as! StationTableViewCell
                viewModel.selectData
                    .subscribe(onNext: { station in
                        if station == item {
                            viewModel.selectedCell = cell.viewModel.selected
                            viewModel.selectedCell.onNext(true)
                        }
                    })
                    .disposed(by: viewModel.disposeBag)
                if let name = item.name, let address = item.address {
                    cell.StationAddress.text = address
                    cell.StationName.text = name

                }
                return cell
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }
}
