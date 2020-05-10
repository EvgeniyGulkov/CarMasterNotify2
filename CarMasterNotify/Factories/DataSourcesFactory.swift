import UIKit
import RxSwift
import RxDataSources

class DataSourcesFactory {
    
    static func reasonsDatasource(viewModel: DetailsViewModel) ->
        RxTableViewSectionedReloadDataSource<DetailsDataSource> {
            return RxTableViewSectionedReloadDataSource<DetailsDataSource>(
                configureCell: { dataSource, tableView, indexPath, item in
                    if indexPath.section == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.details, for: indexPath) as! BaseDarkTableViewCell
                        // toDo need to add car info cell
                        return cell
                    } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.details, for: indexPath) as! BaseDarkTableViewCell
                        let reason = item.reason?.allObjects[indexPath.row] as! Reason
                        let cellViewModel = DetailsCellViewModel(id: reason.id!)
                            cellViewModel.text = Observable.just( reason.text!)
                        if reason.status {
                            cellViewModel.status.onNext(.complete)
                        } else {
                            cellViewModel.status.onNext(.error)
                        }
                            viewModel.reasonsViewModels.append(cellViewModel)
                    
                    viewModel.reasonsViewModels[indexPath.row].text?
                        .bind(to: (cell.textLabel?.rx.text)!)
                        .disposed(by: cell.disposeBag)
                    
                    viewModel.reasonsViewModels[indexPath.row].status
                        .subscribe(onNext: { status in
                            switch status {
                            case .loading:
                                cell.accessoryType = .disclosureIndicator
                            case .complete:
                                cell.accessoryType = .checkmark
                            case .error:
                                cell.accessoryType = .none
                            }
                        })
                        .disposed(by: cell.disposeBag)
                    
                    return cell
                    }
            },
                titleForHeaderInSection: {dataSource,indexPath in
                    return dataSource.sectionModels[indexPath].title
            },
                canEditRowAtIndexPath: {
                    dataSource, indexPath in
                    return false
            })
    }
    
    static func getOrdersDataSource () ->
        RxTableViewSectionedReloadDataSource<OrdersDataSource> { return RxTableViewSectionedReloadDataSource<OrdersDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.order, for: indexPath) as! OrderTableCell
                
                cell.carModel.text = item.model
                cell.orderStatus.text = item.status
                cell.plateNumber.text = item.plateNumber
                cell.vinNumber.text = item.vin
                cell.orderTime.text = DateFormatter.formattedString(date: item.updateDate!, format: "HH:mm")
                return cell
                
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }

    static func settingsDataSource (viewModel: SettingsViewModel) ->
        RxTableViewSectionedReloadDataSource<OrdersDataSource> { return RxTableViewSectionedReloadDataSource<OrdersDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.order, for: indexPath) as! OrderTableCell
                
                cell.carModel.text = item.model
                cell.orderStatus.text = item.status
                cell.plateNumber.text = item.plateNumber
                cell.vinNumber.text = item.vin
                cell.orderTime.text = DateFormatter.formattedString(date: item.updateDate!, format: "HH:mm")
                return cell
                
        },
            titleForHeaderInSection: {dataSource,indexPath in
                return dataSource.sectionModels[indexPath].title
        })
    }
}
