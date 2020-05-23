import UIKit
import RxSwift
import Moya
import SocketIO
import CoreData

class OrderViewModel {
    let dateFormat = "dd.MM.yyyy"
    let disposeBag = DisposeBag()
    var selectData: PublishSubject<Order> = PublishSubject()
    var search: PublishSubject<String> = PublishSubject()
    var displayLastCell:PublishSubject<Int> = PublishSubject()
    var data: PublishSubject<[OrdersDataSource]> = PublishSubject()
    var orders: [Int:Order] = [:]
    var socketClient: SocketClient<CarMasterSocketApi>
    var networkProvider: CustomMoyaProvider<CarMasterApi>
    
    init(networkProvider: CustomMoyaProvider<CarMasterApi>, socketClient: SocketClient<CarMasterSocketApi>) {
        self.networkProvider = networkProvider
        self.socketClient = socketClient
        
        self.displayLastCell.subscribe(onNext: { index in
            if self.orders.values.count > 20 && self.orders.values.count-1 == index {
                self.getData(limit: 10, offset: index)
            }
        })
            .disposed(by: disposeBag)
        
        self.search.asObservable()
            .subscribe(onNext: { text in
                    self.getData(searchText: text.lowercased(), limit: 20, offset: 0)})
            .disposed(by: disposeBag)
    }
    
    func getData(searchText: String = "", limit: Int = 20, offset: Int = 0) {
        getOrdersFromLocalDatabase(searchText: searchText, limit: limit, offset: offset)
        if !searchText.isEmpty {
            self.orders.removeAll()
        }
        Order.getOrdersFromServer(offset: offset, limit: limit, searchText: searchText) {[weak self] error in
            if let error = error {
                print(error)
            } else {
                self?.getOrdersFromLocalDatabase(searchText: searchText, limit: limit, offset: offset)
            }
        }
    }
    
    func getOrdersFromLocalDatabase(searchText: String = "", limit: Int = 20, offset: Int = 0) {
        let orders = Order.orders(offset: offset,
                                  limit: limit,
                                  searchText: searchText)
        orders.forEach {order in
            self.orders[Int(order.number)] = order
        }
        let sections = self.splitByDate(orders: self.orders)
        var orderDataSources: [OrdersDataSource] = []
        sections.forEach {section in
            orderDataSources.append(OrdersDataSource(title: DateFormatter.formattedString(date: section.date, format: dateFormat) , items: section.items))
        }
        self.data.onNext(orderDataSources)
    }
    
    func splitByDate (orders: [Int:Order]) -> [OrderSection] {
        var sections = [String: OrderSection]()
        orders.values.forEach { order in
            let key = order.updateDate?.formatted(OrderSection.dateFormat)
            if sections[key!] == nil {
                sections[key!] = OrderSection(order: order)
            } else {
                if let index = sections[key!]?.items.firstIndex(where: { $0.updateDate! < order.updateDate!
                }) {
                    sections[key!]?.items.insert(order, at: index)
                } else {
                    sections[key!]?.items.append(order)
                }
            }
        }
        return Array (sections.values.map{$0}.sorted(by: {first,second in return first.date > second.date}))
    }
}
