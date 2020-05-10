import UIKit
import RxSwift
import RxDataSources
import SocketIO

class DetailViewModel {
    let dataChanged: PublishSubject<Int>
   // let data: PublishSubject<[DetailDataSource]>
    let newMessage: PublishSubject<String?>
    let socketClient: SocketClient<CarMasterSocketApi>
    let loadMore: PublishSubject<Int>
    
    private let limit = 20
    private let disposeBag = DisposeBag()
    private var networkProvider: CustomMoyaProvider<CarMasterApi>
    
    var messages: [String: MessageModel] = [:]
    var order: Order
    var title: Observable<String>
    
    var messagesViewModels: [UserCellViewModel] = []
    var reasonsViewModels: [ReasonsCellViewModel] = []
    
    init(order:Order, networkProvider: CustomMoyaProvider<CarMasterApi>, socketClient: SocketClient<CarMasterSocketApi>) {
        self.socketClient = socketClient
            // self.data = PublishSubject<[DetailDataSource]>()
        self.networkProvider = networkProvider
        self.order = order
        self.title = Observable.just(String(order.model! + " - " + order.plateNumber!))
        self.dataChanged = PublishSubject()
        self.newMessage = PublishSubject<String?>()
        self.loadMore = PublishSubject()
        
        self.loadMore
            .subscribe(onNext: {index in
                if index == 1 {
                    self.getData(index: 1)
                }
            })
            .disposed(by: disposeBag)
        
        self.dataChanged
            .subscribe(onNext: {index in
                self.getData(index: index)})
            .disposed(by: disposeBag)
        
        self.newMessage.asObservable()
            .subscribe(onNext: {
                if !$0!.isEmpty {
                    self.addMessage(text: $0!)}
            })
            .disposed(by: disposeBag)
        
        self.socketClient.on(event: .getMessage, callback: {[unowned self] data,_ in
            let message = MessageModel.fromData(data: data).first
            message?.toManagedObject(order: self.order)
            DataController.shared.save()
            
            self.updateMessages(messages: [message!])
        })
    }
    
    func getData(index: Int) {
        switch index {
        case 1:
            self.socketClient.emitWithAck(event: .getMessages, ["orderNum":order.number,
                                                                "offset":self.messages.count,
                                                                "limit": limit],
                                          timingOut: 0.5)
            { [unowned self] data in
                guard let code = data.first as? Int else {
                    self.getFromLocalDB(offset: self.messages.count, limit: self.limit)
                    return
                }
                if code == 200 {
                    let messages = MessageModel.fromData(data: data[1])
                    let _ = messages.map {$0.toManagedObject(order: self.order)}
                    DataController.shared.save()
                    self.updateMessages(messages: messages)
                }
                else {
                    self.getFromLocalDB(offset: self.messages.count, limit: self.limit)
                }
            }
        default:
            self.networkProvider.request(.getReasons(orderNumber: Int(self.order.number)), [ReasonModel].self)
                .subscribe(onSuccess: { reasons in
                    let _ = reasons.map {$0.toManagedObject(order: self.order)}
                    DataController.shared.save()
                    self.updateReasons()
                }, onError: {error in
                    print(error)
                    self.updateReasons()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    private func updateReasons() {
        let reasons = self.order.reason?.allObjects as! [Reason]
        self.createReasonsCellViewModels(reasons: reasons)
 //       self.data.onNext([DetailDataSource(detailData: .reasons(reasons: reasons))])
    }
    
    private func updateMessages(messages: [MessageModel]) {
        messages.forEach { [unowned self] message in
            if self.messages[message.id!] == nil {
                self.messages[message.id!] = message
                self.messagesViewModels.append(UserCellViewModel())
            }
        }
        let allMessage = Array<MessageModel>(self.messages.values).sorted(by: {first,second in
            first.date! < second.date!
        })
     //   self.data.onNext([DetailDataSource(detailData: .messages(messages: allMessage))])
    }
    
    private func getFromLocalDB(offset: Int, limit: Int) {
        let messages = Message.messages(offset: offset, limit: limit, order: self.order)
        self.updateMessages(messages: messages.map{$0.toObject()})
    }
    
    func createReasonsCellViewModels(reasons: [Reason]) {
        self.reasonsViewModels.removeAll()
        for reason in reasons {
            self.reasonsViewModels.append(ReasonsCellViewModel(id:reason.id! ,status: .error))
        }
    }
    
    func createMessagesCellViewModels(messages: [MessageModel]) {
        self.messagesViewModels.removeAll()
        for _ in messages {
            self.messagesViewModels.append(UserCellViewModel(status: .complete))
        }
    }
    
    func changeStatus (index: Int) -> (){
        self.networkProvider.request(.changeStatus(id: self.reasonsViewModels[index].id), Int.self)
            .subscribe(
                onSuccess: {_ in self.dataChanged.onNext(0)
            },
                onError: {_ in})
            .disposed(by: disposeBag)
    }
    
    private func addMessage(text: String) {
        socketClient.emitWithAck(event: .addMessage, ["orderNum": self.order.number,
                                                      "message": text], timingOut: 3)
        { data in
            guard let code = data.first as? Int else {
                return
            }
            if code == 200 {
                let message = data[1]
                // self.toLocalDatabase(data: [message])
                //  self.updateMessages(offset: 0, limit: 1)
            }
        }
    }
}
