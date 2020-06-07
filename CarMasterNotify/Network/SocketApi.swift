import Foundation
import SocketIO

enum CarMasterSocketApi: String, RawRepresentable {
    case addMessage = "add message"
    case getMessage = "get new message"
    case getMessages = "get messages"
    case getMessagesResponse = "get messages response"
}

class SocketClient<T:RawRepresentable> where T.RawValue == String {
    private let manager: SocketManager
    private var socket: SocketIOClient
    
    init(nsp: String = "/") {
        self.manager = SocketManager(socketURL: Constants.CarMasterApi.baseUrl, config: [.log(false),.compress, .extraHeaders(["Authorization" : SecureManager.accessToken])])
        self.socket = manager.socket(forNamespace: nsp)
    }
    
    func emit (event: T, with data: SocketData) {
        self.socket.emit(event.rawValue, data)
    }
    
    func emit (event: T, with data:[Any],completion: @escaping (()->())) {
        self.socket.emit(event.rawValue, with: data, completion: completion)
    }
    
    func on (event: T, callback: @escaping NormalCallback) {
        self.socket.on(event.rawValue, callback: callback)
    }
    
    func connect () {
        self.socket.connect()
    }
    
    func emitWithAck (event: T,_ data: SocketData, timingOut: Double, _ callBack: @escaping AckCallback) {
        self.socket.emitWithAck(event.rawValue, data)
            .timingOut(after: timingOut, callback: callBack )
    }
}
