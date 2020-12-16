import Foundation

extension URLComponents {
    
    init<T: ServiceProtocol>(service: T) {
        let url = service.path.reduce(service.baseURL) { (newUrl, nextPath) -> URL in
            newUrl.appendingPathComponent(nextPath)
        }
        self.init(url: url,
                  resolvingAgainstBaseURL: false)!
        queryItems = service.queryItems?.map { key, value in
            URLQueryItem(name: key,
                         value: String(describing: value))
        }
    }
}
