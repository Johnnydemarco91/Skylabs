import Foundation

struct StarWarsLogic {
    static func getPeopleResponse(queryParameters: [String: String]? = nil,
                                  completion: @escaping (Result<PeopleResponse<[Person]>, NetworkError>) -> Void) {
        DefaultConfigurator.default.request(service: PeopleService(queryItems: queryParameters)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    static func getFilm(baseURL: URL,
                        completion: @escaping (Result<Film, NetworkError>) -> Void) {
        DefaultConfigurator.default.request(service: FilmService(baseURL: baseURL)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getVehicle(baseURL: URL,
                           completion: @escaping (Result<Vehicle, NetworkError>) -> Void) {
        DefaultConfigurator.default.request(service: VehicleService(baseURL: baseURL)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

