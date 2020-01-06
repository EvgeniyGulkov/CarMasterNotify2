import Foundation
import Moya
import RxSwift
import KeychainAccess

class ResponseParser {
    let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
    }
    
    func parseResponse<T:Decodable> (from response: Response, to model: T.Type) -> T?{
        let data = try? jsonDecoder.decode(T.self, from: response.data)
        return data
    }
}
