import Foundation

protocol ProviderProtocol {
    func request<T: ServiceProtocol>(service: T,
                                     completion: @escaping (Result<Data?, NetworkError>) -> Void)
}
