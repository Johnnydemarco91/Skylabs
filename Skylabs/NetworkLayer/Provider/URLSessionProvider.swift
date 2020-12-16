import Foundation

class URLSessionProvider: ProviderProtocol {
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(service: T,
                    completion: @escaping (Result<Data?, NetworkError>) -> Void) where T: ServiceProtocol {
        let request = URLRequest(service: service)
        let task = session
            .dataTask(request: request,
                      completionHandler: { data, response, error in
                        DispatchQueue.main.async {
                            let httpResponse = response as? HTTPURLResponse
                            guard error == nil else {
                                return completion(.failure(NetworkError.create(with: error?.localizedDescription)))
                            }
                            guard let response = httpResponse else {
                                return completion(.failure(NetworkError.create(with: "Empty Response")))
                            }
                            switch response.statusCode {
                            case 200...299:
                                completion(.success(data))
                            default:
                                completion(.failure(NetworkError.create(with: "Response error")))
                            }
                        }
                      })
        task.resume()
    }
}
