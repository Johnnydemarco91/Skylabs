struct PeopleDescriptionViewContent {
    let id: Int?
    let height: String
    let mass: String
    let gender: String
    let birthyear: String
    let hairColor: String

    static func create(from people: People) -> PeopleDescriptionViewContent {
        .init(id: people.id,
              height: people.height,
              mass: people.mass,
              gender: people.gender,
              birthyear: people.birthYear,
              hairColor: people.hairColor)
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
