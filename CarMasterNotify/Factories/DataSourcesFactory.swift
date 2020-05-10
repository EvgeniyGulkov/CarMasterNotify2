import UIKit
import RxSwift
import RxDataSources

class DataSourcesFactory {
    
    static func reasonsDatasource(viewModel: ReasonViewModel) ->
        RxTableViewSectionedReloadDataSource<ReasonDataSource> {
            return RxTableViewSectionedReloadDataSource<ReasonDataSource>(
                configureCell: { dataSource, tableView, indexPath, item in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "reasonsCell", for: indexPath) as! ReasonsCell
                    
                    viewModel.reasonsViewModels[indexPath.row].text = Observable.just( item.text!)
                    
                    if item.status {
                        viewModel.reasonsViewModels[indexPath.row].status.onNext(.complete)
                    } else {
                        viewModel.reasonsViewModels[indexPath.row].status.onNext(.error)
                    }
                    
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
                    
            },
                canEditRowAtIndexPath: {
                    dataSource, indexPath in
                    return false
            })
    }
    
    static func getOrdersDataSource () ->
        RxTableViewSectionedReloadDataSource<OrdersDataSource> { return RxTableViewSectionedReloadDataSource<OrdersDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableCell
                
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableCell
                
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
