import Moya
import RxSwift
import Alamofire

class CustomMoyaProvider<Target: TargetType>: MoyaProvider<Target> {
    let provider: MoyaProvider<Target>
    let jsonDecoder:JSONDecoder
    
    override init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping, requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping, stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub, callbackQueue: DispatchQueue? = nil, session: Session = MoyaProvider<Target>.defaultAlamofireSession(), plugins: [PluginType] = [], trackInflights: Bool = false)
    {
        let authPlugin = AccessTokenPlugin { _ in
            SecureManager.accessToken }
        let evaluators = [
          "www.carmasterapi.me.uk":
            PinnedCertificatesTrustEvaluator(certificates: [
                Certificates.carMasterApiCertificate
            ])
        ]
        
        let alamofireSession = Session(serverTrustManager: ServerTrustManager(evaluators: evaluators))
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: alamofireSession, plugins: [authPlugin, NetworkLoggerPlugin()], trackInflights: trackInflights)
        
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

    }
    
    func request(_ token: Target) -> Single<Response> {
        let request = self.provider.rx.request(token)
        return request
            .flatMap{response in
                if (400...499).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        return self.refreshSessionToken(token: SecureManager.refreshToken)
                            .do(
                                onSuccess:{userdata in
                                    SecureManager.saveUserData(userdata: userdata)},
                                onError: {_ in SecureManager.SignOut()})
                            .flatMap{_ in return self.provider.rx.request(token)}
                    } else if response.statusCode == 403 {
                        SecureManager.SignOut()
                        return Single.create {
                            $0(.error(CarMasterError.userNotFound))
                            return Disposables.create()
                        }
                    } else {
                        return Single.create {
                            $0(.error(CarMasterError.userExist))
                            return Disposables.create()
                        }
                    }
                } else {
                    return Single.create {
                        $0(.success(response))
                        return Disposables.create()
                    }
                }
        }
    }
    
    func refreshSessionToken (token : String) -> Single<UserDataModel> {
        return Single.create { single in
            let provider = CustomMoyaProvider<CarMasterApi.Auth>()
            let request = CarMasterRefreshTokenRequest()
            provider.request(.refreshToken(request: request)){
                result in
                switch result {
                case .success(let response):
                    if response.statusCode == 200 {
                    let data = try? response.map(UserDataModel.self, atKeyPath: nil, using: self.jsonDecoder, failsOnEmptyData: false)
                    single(.success(data!))
                    }
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
