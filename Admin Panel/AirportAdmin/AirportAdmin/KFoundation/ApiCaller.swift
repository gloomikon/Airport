import Alamofire
import BrightFutures

enum AnyError: Error {
    case serverError
    case parsingError
}

extension AnyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return NSLocalizedString("Server error", comment: "Server error")
        case .parsingError:
            return NSLocalizedString("Parsing error", comment: "Could not parse data")
        }
    }
}

class ApiCaller {
    static func makeRequest<T>(endPoint: String, method: HTTPMethod, params: Parameters? = nil, type: T.Type) -> Future<T, AnyError> where T: Decodable {
        let url = "http://localhost:8080/\(endPoint)"
        let promise = Promise<T, AnyError>()
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default)
            .response { response in
                guard response.error == nil,
                    let data = response.data else {
                        promise.failure(.serverError)
                        return
                }
                do {
                    let parsed = try JSONDecoder().decode(type, from: data)
                    promise.success(parsed)
                }
                catch {
                    promise.failure(.parsingError)
                }
        }
        return promise.future
    }
}
