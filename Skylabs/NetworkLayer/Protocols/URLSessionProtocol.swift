import Foundation

public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

    func dataTask(request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    public func dataTask(request: URLRequest,
                         completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request,
                        completionHandler: completionHandler)
    }
}
