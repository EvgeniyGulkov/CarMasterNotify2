import UIKit
import RxSwift
import RxDataSources

class DataSourcesFactory {

    static func getDetailsDatasource(viewModel: DetailViewModel) ->
     RxTableViewSectionedReloadDataSource<DetailDataSource> {
         return RxTableViewSectionedReloadDataSource<DetailDataSource>(
           configureCell: { dataSource, tableView, indexPath, _ in
             let source = dataSource[0].datasourceType

             switch source {
             case .reasons( let reasons):
                 let cell = tableView.dequeueReusableCell(withIdentifier: "reasonsCell", for: indexPath) as! ReasonsCell
                 
                 viewModel.reasonsViewModels[indexPath.row].text = Observable.just( reasons[indexPath.row].text!)
                 
                 if reasons[indexPath.row].isComplete! {
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
                 
             case .recommendations( let recommendations):
                 viewModel.recommendationsViewModels [indexPath.row].text = Observable.just(recommendations[indexPath.row].text!)
                 
                 viewModel.recommendationsViewModels [indexPath.row].author = Observable.just(String(recommendations[indexPath.row].userName!))
                 
                 if recommendations[indexPath.row].isMy! {
                     let cell = tableView.dequeueReusableCell(withIdentifier: "userRecommendationsCell", for: indexPath) as! UserMessageCell
                     
                    viewModel.recommendationsViewModels[indexPath.row].text!
                         .bind(to: cell.messageText.rx.text)
                         .disposed(by: cell.disposeBag)
                     
                    viewModel.recommendationsViewModels[indexPath.row].status
                         .subscribe(onNext: {status in
                             switch status {
                             case .loading:
                                 cell.progressBar.isHidden = false
                                 cell.progressBar.rotate()
                             case .complete:
                                 cell.progressBar.isHidden = true
                             case .error:
                                 cell.progressBar.isHidden = true
                                 cell.errorImage.isHidden = false
                             }
                         })
                         .disposed(by: cell.disposeBag)
                     
                     return cell
                 } else {
                     let cell = tableView.dequeueReusableCell(withIdentifier: "recommendationsCell", for: indexPath) as! MessageCell
                     
                    viewModel.recommendationsViewModels[indexPath.row].text!
                         .bind(to: cell.messageText.rx.text)
                         .disposed(by: cell.disposeBag)
                     
                    viewModel.recommendationsViewModels[indexPath.row].author!
                         .bind(to: cell.author.rx.text)
                         .disposed(by: cell.disposeBag)
                     
                     return cell
                 }
             }
         },
         canEditRowAtIndexPath: {
             dataSource, indexPath in
             let source = dataSource[0].datasourceType
             switch source {
             case .reasons(let reasons):
                 return !reasons[indexPath.row].isComplete!
             case .recommendations( _):
                 return false
             }

         })
     }
    
    static func getOrdersDataSource () ->
    RxTableViewSectionedReloadDataSource<OrdersDataSource> { return RxTableViewSectionedReloadDataSource<OrdersDataSource>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableCell

            cell.carModel.text = item.model
            cell.orderStatus.text = item.status
            cell.plateNumber.text = item.plateNumber
            cell.vinNumber.text = item.vinNumber
            cell.orderTime.text = DateFormatter.formattedString(date: item.date!, format: "HH:mm")
            return cell
    
        },
        titleForHeaderInSection: {dataSource,indexPath in
            return dataSource.sectionModels[indexPath].title
        })
    }
}
