import RxSwift
import RxCocoa
import RxDataSources

class DataSourcesFactory {

    static func reasonsDatasource(viewModel: DetailsViewModel) ->
        RxTableViewSectionedReloadDataSource<DetailsDataSource> {
            return RxTableViewSectionedReloadDataSource<DetailsDataSource>(
                configureCell: { dataSource, tableView, indexPath, item in
                    if indexPath.section == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.carInfo,
                                                                 for: indexPath)
                        return cell
                    }
                    if indexPath.section == 1 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.details,
                                                                   for: indexPath) as? BaseDarkTableViewCell else {
                                                                    return UITableViewCell()
                        }
                        if let reason = item.reason?.allObjects[indexPath.row] as? Reason {
                        let cellViewModel = DetailsCellViewModel(id: reason.id!)
                            cellViewModel.text = Observable.just( reason.text!)
                        if reason.status {
                            cellViewModel.status.onNext(.complete)
                        } else {
                            cellViewModel.status.onNext(.error)
                        }
                            viewModel.reasonsViewModels.append(cellViewModel)
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
                    } else {
                        return UITableViewCell()
                    }
            },
                titleForHeaderInSection: {dataSource,indexPath in
                    return dataSource.sectionModels[indexPath].title
            },
                canEditRowAtIndexPath: { _, _ in
                    return false
            })
    }

    static func getOrdersDataSource () ->
        RxTableViewSectionedReloadDataSource<OrdersDataSource> { return RxTableViewSectionedReloadDataSource<OrdersDataSource>(
            configureCell: { dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.order,
                                                               for: indexPath) as? OrderTableCell else {
                                                                return UITableViewCell()
                }
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.order,
                                                               for: indexPath) as? OrderTableCell else {
                                                                return UITableViewCell()
                }

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
