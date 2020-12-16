import Foundation
import UIKit

struct DefaultConfigurator {
    static let `default`: DefaultConfigurator = DefaultConfigurator()

    private func sessionProvider<T>(service: T) -> URLSessionProvider where T: ServiceProtocol {
        let conf = URLSessionConfiguration.default
        conf.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.always
        conf.requestCachePolicy = .reloadIgnoringCacheData
        let session = URLSession(configuration: conf)
        return URLSessionProvider(session: session)
    }

    func request<T>(service: T,
                    completion: @escaping (Result<T.ResponseModel, NetworkError>) -> Void) where T: ServiceProtocol {
        #if DEBUG
        print("REQUEST: \(service)")
        #endif
        self.sessionProvider(service: service).request(service: service) { result in
            switch result {
            case .success(let data):
                #if DEBUG
                print("RESPONSE: \(String(decoding: data ?? Data(), as: UTF8.self))")
                #endif
                self.decode(service: service,
                            data: data,
                            completion: completion)
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }

    func decode<T>(service: T, data: Data?,
                   completion: @escaping (Result<T.ResponseModel, NetworkError>) -> Void) where T: ServiceProtocol {
        URLCache.shared.removeAllCachedResponses()
        guard let data = data else {
            return completion(.failure(NetworkError.create(with: "Data not present")))
        }
        do {
            let model = try JSONDecoder().decode(T.ResponseModel.self, from: data)
            completion(.success(model))
        } catch let error {
            print(error)
            return completion(.failure(NetworkError.create(with: "Error with parsing")))
        }
    }
}
