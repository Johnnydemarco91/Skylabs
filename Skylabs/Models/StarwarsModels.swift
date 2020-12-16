import Foundation

struct People: Codable {
    var id: Int? {
        guard let url = URL(string: url) else {
            return nil
        }
        return Int(url.lastPathComponent)
    }
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
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
        let episode_id: Int
        let opening_crawl: String
        let director: String
        let producer: String
        let release_date: String
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
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let cargo_capacity: String
    let consumables: String
    let vehicle_class: String
}
