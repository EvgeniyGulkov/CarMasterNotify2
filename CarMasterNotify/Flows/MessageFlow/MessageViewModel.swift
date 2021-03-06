//
//  MessageViewModel.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import RxSwift
import CoreData
import Starscream

class MessageViewModel {
    private let limit = 20
    private let disposeBag = DisposeBag()

    var socketClient: SocketClient<CarMasterSocketApi>
    var order: Order
    var title: Observable<String>
    var tableContentOffset: PublishSubject<CGPoint>
    var messageCount: Int = 0
    var sendMessageTapped: PublishSubject<String?>

    init(order: Order, socketClient: SocketClient<CarMasterSocketApi>) {
        self.order = order
        self.socketClient = socketClient
        self.title = Observable.just("\(order.manufacturer!) \(order.model!) - \(order.plateNumber!)")
        self.tableContentOffset = PublishSubject()
        self.sendMessageTapped = PublishSubject()
        self.initSocket()

        self.sendMessageTapped
            .subscribe(onNext: {text in
                self.addMessage(text: text!)
            })
            .disposed(by: self.disposeBag)

        self.tableContentOffset.subscribe(onNext: {[unowned self] point in
            if point.y < -30 {
                self.getMessages(offset: self.messageCount)
            }
        })
            .disposed(by: self.disposeBag)
    }

    func initSocket() {
        self.socketClient.on(event: .getMessage, callback: {_,_ in
        })
    }

    func getMessages(offset: Int = 0) {
        self.socketClient.emitWithAck(event: .getMessages, ["orderNum": Int(self.order.number),
                                                            "offset": offset,
                                                            "limit": limit],
                                      timingOut: 5) {_ in
        }
    }

    func addMessage(text: String) {
        guard !text.isEmpty else {
            return
        }
        let context = DataController.shared.main
        let message = Message(context: context)
        message.text = text
        message.status = CellState.loading.rawValue
        message.isMy = true
        message.created = Date()
        DataController.shared.save()

        socketClient.emitWithAck(event: .addMessage, ["orderNum": self.order.number,
                                                      "message": text], timingOut: 20) { _ in
        }
    }
}
