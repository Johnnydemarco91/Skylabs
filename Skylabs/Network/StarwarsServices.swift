import Foundation

struct PeopleService: StarWarsProtocol {
    typealias ResponseModel = PeopleResponse<[Person]>
    var method: HTTPMethod = .get
    var path: [String] = ["people"]
    var queryItems: Parameters?

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

struct FilmService: StarWarsProtocol {
    typealias ResponseModel = Film
    var method: HTTPMethod = .get
    var path: [String] = []
    var baseURL: URL

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

struct VehicleService: StarWarsProtocol {
    typealias ResponseModel = Vehicle
    var method: HTTPMethod = .get
    var path: [String] = []
    var baseURL: URL

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
