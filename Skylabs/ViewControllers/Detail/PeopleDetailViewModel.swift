import Foundation

class PeopleDetailViewModel {
    let people: People
    var films: [Film]?
    var vehicles: [Vehicle]?
    let dispatchGroup = DispatchGroup()

    init(people: People,
         films: [Film]? = nil,
         vehicles: [Vehicle]? = nil) {
        self.people = people
        self.films = films
        self.vehicles = vehicles
    }

    func prepareFilms(completion: @escaping (() -> Void)) {
        var films = [Film]()
        people.films.forEach {
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
        people.vehicles.forEach {
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
