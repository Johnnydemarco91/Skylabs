import Foundation

struct PeopleService: StarWarsProtocol {
    typealias ResponseModel = PeopleResponse<[People]>
    var method: HTTPMethod = .get
    var path: [String] = ["people"]
    var queryItems: Parameters?
}

struct FilmService: StarWarsProtocol {
    typealias ResponseModel = Film
    var method: HTTPMethod = .get
    var path: [String] = []
    var baseURL: URL
}

struct VehicleService: StarWarsProtocol {
    typealias ResponseModel = Vehicle
    var method: HTTPMethod = .get
    var path: [String] = []
    var baseURL: URL
}
