import Foundation

extension URLRequest {
    
    init<T: ServiceProtocol>(service: T) {
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!)
        
        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value,
                     forHTTPHeaderField: key)
        }

        guard service.parametersEncoding == .json else {
                return
        }
        switch service.task {
        case .requestPlain:
            return
        case .requestJson(let data):
            addValue("application/json",
                     forHTTPHeaderField: "Content-Type")
            httpBody = data
        }
    }
}
