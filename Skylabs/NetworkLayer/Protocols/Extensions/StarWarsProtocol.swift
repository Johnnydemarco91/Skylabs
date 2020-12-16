import Foundation

protocol StarWarsProtocol: ServiceProtocol {}

extension StarWarsProtocol {
    var baseURL: URL {
        URL(string: "https://swapi.dev/api")!
    }
}
