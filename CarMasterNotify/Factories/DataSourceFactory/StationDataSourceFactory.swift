//
//  StationDataSourceFactory.swift
//  CarMasterNotify
//
//  Created by Admin on 24.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class StationDataSourceFactory {
    static func stationDataSource (viewModel: StationsViewModel) ->
        RxTableViewSectionedReloadDataSource<StationDataSource> { return RxTableViewSectionedReloadDataSource<StationDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.Station,
                                                               for: indexPath) as? StationTableViewCell else {
                                                                return UITableViewCell()
                }
                viewModel.selectData
                    .subscribe(onNext: { station in
                        if station == item {
                            viewModel.selectedCell = cell.viewModel.selected
                            viewModel.selectedCell.onNext(true)
                        }
                    })
                    .disposed(by: viewModel.disposeBag)
                if let name = item.name, let address = item.address {
                    cell.stationAddress.text = address
                    cell.stationName.text = name

                }
                return cell
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }
}
