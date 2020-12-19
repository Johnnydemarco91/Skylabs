import Foundation

class PersonDetailViewModel {
    let person: Person
    var films: [Film]?
    var vehicles: [Vehicle]?
    let dispatchGroup = DispatchGroup()

    init(person: Person,
         films: [Film]? = nil,
         vehicles: [Vehicle]? = nil) {
        self.person = person
        self.films = films
        self.vehicles = vehicles
    }

    func prepareFilms(completion: @escaping (() -> Void)) {
        var films = [Film]()
        person.films.forEach {
            guard let url = URL(string: $0) else {
                return
            }
            dispatchGroup.enter()
            StarWarsLogic.getFilm(baseURL: url) { [unowned self] result in
                switch result {
                case .success(let film):
                    films.append(film)
                    dispatchGroup.leave()
                case .failure:
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.films = films
            completion()
        }
    }

    func prepareVehicles(completion: @escaping (() -> Void)) {
        var vehicles = [Vehicle]()
        person.vehicles.forEach {
            guard let url = URL(string: $0) else {
                return
            }
            dispatchGroup.enter()
            StarWarsLogic.getVehicle(baseURL: url) { [unowned self] result in
                switch result {
                case .success(let vehicle):
                    vehicles.append(vehicle)
                    dispatchGroup.leave()
                case .failure:
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.vehicles = vehicles
            completion()
        }
    }
}
