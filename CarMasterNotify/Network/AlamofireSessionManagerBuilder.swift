import Foundation
import Alamofire
import Moya

class AlamofireSessionManagerBuilder {
    var policies: [String: ServerTrustPolicy]?
    var configuration = URLSessionConfiguration.default

    init(includeSSLPinning: Bool = true) {
        
        if includeSSLPinning {
            let allPublicKeys = ServerTrustPolicy.pinPublicKeys(publicKeys: ServerTrustPolicy.publicKeys(in: Bundle.main), validateCertificateChain: true, validateHost: true)
        self.policies = ["www.carmasterapi.me.uk": allPublicKeys]
        }
    }
    
    func build() -> Manager {
        var serverTrustPolicyManager: CustomServerTrustPolicyManager?
        
        if let policies = self.policies {
            serverTrustPolicyManager = CustomServerTrustPolicyManager(policies: policies)
        }
        
        let manager = Manager(configuration: configuration,
        serverTrustPolicyManager: serverTrustPolicyManager)
                manager.startRequestsImmediately = false
        
        return manager
    }
}
