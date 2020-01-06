import UIKit
import RxSwift
import Moya
import KeychainAccess

class OrderViewModel {
    let dateFormat = "dd.MM.yyyy"
    let disposeBag = DisposeBag()
    let selectData: PublishSubject<OrderModel>
    let search: PublishSubject<String>
    let displayLastCell:PublishSubject<Int>
    
    var data: PublishSubject<[OrdersDataSource]>
    var networkProvider: NetworkProvider
    var orders: [Int:OrderModel]
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
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
                if text.count > 2 || text.count == 0{
                self.getData(searchText: text, limit: 20, offset: 0)}
            })
            .disposed(by: disposeBag)
    }
    
    func getData(searchText: String = "", limit: Int = 20, offset: Int = 0) {
        if searchText.count>2 {
            self.orders.removeAll()
        }
        let cars = self.networkProvider.request(from: .getCars(offset: offset, limit: limit, searchText: searchText), [OrderModel].self)
        cars.subscribe(
            onSuccess: {orders in
                orders.forEach{order in
                    self.orders[order.orderNumber!] = order
                }
                let sections = self.splitByDate(orders: self.orders)
                var orderDataSources: [OrdersDataSource] = []
                sections.forEach {section in
                    orderDataSources.append(OrdersDataSource(title: DateFormatter.formattedString(date: section.date, format: "dd.MM.yyyy") , items: section.items))
                }
                if !orders.isEmpty {
                self.data.onNext(orderDataSources)
                }
        },
            onError: {error in print(error.localizedDescription)})
        .disposed(by: disposeBag)
    }
    
    func splitByDate (orders: [Int:OrderModel]) -> [OrderSection] {
        var sections = [String: OrderSection]()
        orders.values.forEach { order in
            let key = order.date?.formatted(OrderSection.dateFormat)
            if sections[key!] == nil {
                sections[key!] = OrderSection(order: order)
            } else {
                if let index = sections[key!]?.items.firstIndex(where: { $0.date! > order.date!
                }) {
                    sections[key!]?.items.insert(order, at: index)
                } else {
                    sections[key!]?.items.append(order)
                }
            }
        }
        return Array (sections.values.map{$0}.sorted(by: {first,second in return first.date < second.date}))
    }
}
