struct PersonDescriptionViewContent {
    let id: Int?
    let height: String
    let mass: String
    let gender: String
    let birthyear: String
    let hairColor: String

    static func create(from person: Person) -> PersonDescriptionViewContent {
        .init(id: person.id,
              height: person.height,
              mass: person.mass,
              gender: person.gender,
              birthyear: person.birthYear,
              hairColor: person.hairColor)
    }
}

struct FilmViewContent {
    let title: String
    let releaseDate: String
    let openingCrawl: String
}

struct VehicleViewContent {
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

    static func create(from vehicle: Vehicle) -> VehicleViewContent {
        .init(name: vehicle.name,
              model: vehicle.model,
              manufacturer: vehicle.manufacturer,
              length: vehicle.length,
              maxAtmospheringSpeed: vehicle.maxAtmospheringSpeed,
              crew: vehicle.crew,
              passengers: vehicle.passengers,
              cargoCapacity: vehicle.cargoCapacity,
              consumables: vehicle.consumables,
              vehicleClass: vehicle.vehicleClass)
    }
}
