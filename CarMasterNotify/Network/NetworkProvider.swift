import Foundation
import RxSwift
import Moya
import KeychainAccess
import Alamofire

class NetworkProvider {
    
    let keychain = Keychain()
    let parser = ResponseParser()
    
    func request<T:Codable>(from method: CarMasterApi, _ type: T.Type) -> Single<T> {
        switch method {
        case .signIn(let login, let password):
            return Single<T>.create{ single in
                let provider = MoyaProvider<CarMasterApi>(manager: AlamofireSessionManagerBuilder().build())
                provider.request(.signIn(login: login, password: password)) { result in
                    switch result {
                    case .success(let response):
                        if (response.statusCode == 200) {
                            let data = self.parser.parseResponse(from: response, to: TokensModel.self)
                            let keychain = Keychain()
                            try? keychain.set((data?.accessToken!)!, key: "access_token")
                            try? keychain.set((data?.refreshToken!)!, key: "refresh_token")
                        }
                            single(.success(response.statusCode as! T))
                        
                    case .failure(let error):
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
            
        case .getCars(let offset, let limit, let searchText):
            return Single<T>.create{ single in
                let token = try? self.keychain.getString("access_token")
                let authPlugin = AccessTokenPlugin { token! }
                let provider = MoyaProvider<CarMasterApi>(manager: AlamofireSessionManagerBuilder().build(), plugins: [authPlugin])
                
                provider.request(.getCars(offset: offset, limit: limit, searchText: searchText)) { result in
                    switch result {
                    case .success(let response):
                        if let data = self.parser.parseResponse(from: response, to: [OrderModel].self) as? T {
                            single(.success(data))
                        }
                        
                    case .failure(let error):
                        print(error.errorDescription ?? "Unknown error")
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
            
        case .getReasons(let orderNumber):
            return Single<T>.create{ single in
                let token = try? self.keychain.getString("access_token")
                let authPlugin = AccessTokenPlugin { token! }
                let provider = MoyaProvider<CarMasterApi>(manager: AlamofireSessionManagerBuilder().build(), plugins: [authPlugin])
                
                provider.request(.getReasons(orderNumber: orderNumber)) { result in
                    switch result {
                    case .success(let response):
                        if let data = self.parser.parseResponse(from: response, to: [ReasonModel].self) as? T {
                            single(.success(data))
                        }
                        
                    case .failure(let error):
                        print(error.errorDescription ?? "Unknown error")
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
            
        case .getRecommendations(let orderNumber):
            return Single<T>.create{ single in
                let token = try? self.keychain.getString("access_token")
                let authPlugin = AccessTokenPlugin { token! }
                let provider = MoyaProvider<CarMasterApi>(manager: AlamofireSessionManagerBuilder().build(), plugins: [authPlugin])
                
                provider.request(.getRecommendations(orderNumber: orderNumber)) { result in
                    switch result {
                    case .success(let response):
                        if response.statusCode == 200 {
                            if let data = self.parser.parseResponse(from: response, to: [RecommendationModel].self) as? T {
                            single(.success(data))
                            }
                        }
                    case .failure(let error):
                        print(error.errorDescription ?? "Unknown error")
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
            
        case .changeStatus(let id):
            return Single<T>.create{ single in
                let token = try? self.keychain.getString("access_token")
                let authPlugin = AccessTokenPlugin { token! }
                let provider = MoyaProvider<CarMasterApi>(manager: AlamofireSessionManagerBuilder().build(), plugins: [authPlugin])
                
                provider.request(.changeStatus(id: id)) { result in
                    switch result {
                    case .success(let response):
                            let code = response.statusCode as! T
                            single(.success(code))
                        
                    case .failure(let error):
                        print(error.errorDescription ?? "Unknown error")
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
        case .addMessage(let text, let order):
            return Single<T>.create{ single in
                let token = try? self.keychain.getString("access_token")
                let authPlugin = AccessTokenPlugin { token! }
                let provider = MoyaProvider<CarMasterApi>(manager: AlamofireSessionManagerBuilder().build(), plugins: [authPlugin])
                
                provider.request(.addMessage(text: text, order: order)) { result in
                    switch result {
                    case .success(let response):
                            let code = response.statusCode as! T
                            single(.success(code))
                    case .failure(let error):
                        print(error.errorDescription ?? "Unknown error")
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
        }
    }
}
