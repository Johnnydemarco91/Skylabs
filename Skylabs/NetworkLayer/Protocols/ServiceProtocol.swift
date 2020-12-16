import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    /// The Model associated for the response.
    associatedtype ResponseModel: Decodable
    
    /// The base url of the request.
    var baseURL: URL { get }
    
    /// The Path of the request.
    var path: [String] { get }
    
    var queryItems: Parameters? { get }
    
    /// The kind of the request.
    var method: HTTPMethod { get }
    
    /// The request parameters type.
    var task: Task { get }
    
    /// The headers of the request.
    var headers: Headers? { get }
    
    /// The kind of encoding for parameters.
    var parametersEncoding: ParametersEncoding { get }
    
    /// Parameters of the request.
    var parameters: Parameters? { get }
}

extension ServiceProtocol {
    var baseURL: URL {
        URL(string: "")!
    }
    
    var headers: Headers? {
        [:]
    }
    
    var queryItems: Parameters? {
        [:]
    }
    
    var parameters: Parameters? {
        [:]
    }

    var task: Task {
        if
            let params = parameters,
            params.count > 0,
            let data = try? JSONSerialization.data(withJSONObject: params,
                                                   options: []) {
            return .requestJson(data)
        } else {
            return .requestPlain
        }
    }
    
    var parametersEncoding: ParametersEncoding {
        guard self.isJsonRequired() else {
            return .url
        }
        return .json
    }
    
    func isJsonRequired() -> Bool {
        self.method == .post || self.method == .put
    }
}
