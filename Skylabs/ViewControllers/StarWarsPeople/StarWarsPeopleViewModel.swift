import Foundation

enum PeopleLayout {
    case list
    case collection
}

class StarWarsPeopleViewModel {
    let layout: PeopleLayout
    var people = [People]()
    var next: String?
    let dispatchGroup = DispatchGroup()

    init(layout: PeopleLayout) {
        self.layout = layout
    }

    func updatePeople(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        StarWarsLogic.getPeopleResponse(queryParameters: next?.queryParameters) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.next = response.next
                guard !self.people.isEmpty
                else {
                    self.people = response.results
                    completion(.success(()))
                    return
                }
                self.people.append(contentsOf: response.results)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

//    func prepareFilms(from people: People) {
//        people.films.forEach {
//            guard let url = URL(string: $0) else {
//                return
//            }
//            StarWarsLogic.getFilm(baseURL: url) { [unowned self] result in
//                switch result {
//                case .success(let film):
//
//                case .failure(let error):
//                    #warning("show error?")
//                }
//            }
//        }
//    }
//
//    func configureVehicles(from people: SWPeople) {
//        people.vehicles.forEach {
//            guard let url = URL(string: $0) else {
//                return
//            }
//            StarWarsLogic.getVehicle(baseURL: url) { [unowned self] result in
//                switch result {
//                case .success(let film):
//                    let filmView = FilmView()
//                    filmView.configure(from: film)
//                    self.stackView.addArrangedSubview(filmView)
//                case .failure(let error):
//                    #warning("show error?")
//                }
//            }
//        }
//    }

    func prepareForDetail(completion: (PeopleDetailViewModel) -> Void) {
        dispatchGroup.enter()
        
    }
}
