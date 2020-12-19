import Foundation

struct Person: Codable {
    var id: Int? {
        guard let url = URL(string: url) else {
            return nil
        }
        return Int(url.lastPathComponent)
    }
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
}

struct PeopleResponse<T: Codable>: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results : T
}

struct Film: Codable {
        let title: String
        let episodeId: Int
        let openingCrawl: String
        let director: String
        let producer: String
        let releaseDate: String
        let characters: [String]
        let planets: [String]
        let starships: [String]
        let vehicles: [String]
        let species: [String]
        let created: String
        let edited: String
        let url: String
}

struct Vehicle: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let consumables: String
    let vehicleClass: String
}
