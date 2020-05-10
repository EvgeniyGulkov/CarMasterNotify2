import UIKit
import RxSwift
import Moya
import SocketIO
import CoreData

class OrderViewModel {
    let dateFormat = "dd.MM.yyyy"
    let disposeBag = DisposeBag()
    let selectData: PublishSubject<Order>
    let search: PublishSubject<String>
    let displayLastCell:PublishSubject<Int>
    let socketClient: SocketClient<CarMasterSocketApi>
    
    var data: PublishSubject<[OrdersDataSource]>
    var networkProvider: CustomMoyaProvider<CarMasterApi>
    var orders: [Int:Order]
    
    init(networkProvider: CustomMoyaProvider<CarMasterApi>, socketClient: SocketClient<CarMasterSocketApi>) {
        self.networkProvider = networkProvider
        self.socketClient = socketClient
        self.selectData = PublishSubject()
        self.search = PublishSubject()
        self.data = PublishSubject()
        self.displayLastCell = PublishSubject()
        self.orders = [:]
        
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
        
        getOrdersFromLocalDatabase()
    }
    
    func getData(searchText: String = "", limit: Int = 20, offset: Int = 0) {
        self.getOrdersFromLocalDatabase(searchText: searchText, limit: limit, offset: offset)
        if !searchText.isEmpty {
            self.orders.removeAll()
        }
        networkProvider.request(.getCars(offset: offset, limit: limit, searchText: searchText), [OrderModel].self)
            .subscribe(onSuccess: { [unowned self] orders in
                let _ = orders.map { $0.toManagedObject() }
                DataController.shared.save()
                self.socketClient.connect()
            },
                       onError: {error in
                        print(error)
            })
            .disposed(by: disposeBag)
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
            orderDataSources.append(OrdersDataSource(title: DateFormatter.formattedString(date: section.date, format: "dd.MM.yyyy") , items: section.items))
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
