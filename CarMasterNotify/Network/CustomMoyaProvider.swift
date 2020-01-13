import Moya
import RxSwift
import Alamofire

class CustomMoyaProvider<Target: TargetType>: MoyaProvider<Target> {
    let provider: MoyaProvider<Target>
    let jsonDecoder:JSONDecoder
    
    override init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping, requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping, stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub, callbackQueue: DispatchQueue? = nil, session: Session = MoyaProvider<Target>.defaultAlamofireSession(), plugins: [PluginType] = [], trackInflights: Bool = false)
    {
        let authPlugin = AccessTokenPlugin { _ in SettingsHelper.accessToken() }
        let evaluators = [
          "www.carmasterapi.me.uk":
            PinnedCertificatesTrustEvaluator(certificates: [
                Certificates.carMasterApiCertificate
            ])
        ]
        
        let alamofireSession = Session(serverTrustManager: ServerTrustManager(evaluators: evaluators))
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: alamofireSession, plugins: [authPlugin], trackInflights: trackInflights)
        
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

    }
    
    func request<T:Decodable>(_ token: Target, _ type: T.Type) -> Single<T> {
        let request = self.provider.rx.request(token)
          return request
            .flatMap{result in
                if result.statusCode == 401 {
                    return self.refreshSessionToken(token: SettingsHelper.refreshToken())
                    .do(
                        onSuccess:{userdata in SettingsHelper.saveUserData(userdata: userdata)},
                        onError: {_ in})
                        .flatMap{_ in return self.provider.rx.request(token)}
                } else {
                    return Single.just(result)
                }
            }
          .map(T.self, atKeyPath: nil, using: self.jsonDecoder, failsOnEmptyData: false)
        }

    func signInRequest (_ token: Target) -> Single<Int> {
        return self.provider.rx.request(token)
            .map { response in
                if response.statusCode == 200 {
                    let userdata = try? response.map(UserDataModel.self)
                    SettingsHelper.saveUserData(userdata: userdata!)
                }
                return response.statusCode
        }
    }
    
    func refreshSessionToken (token : String) -> Single<UserDataModel> {
        return Single.create { single in
        let provider = MoyaProvider<CarMasterApi>()
            provider.request(.refreshToken(refreshToken: token)){
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
