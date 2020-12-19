import Foundation

enum PeopleLayout {
    case list
    case collection
}

enum ShowableList {
    case generic
    case filtered
}

enum AlphabeticalOrder {
    case ascending
    case descending
}

struct StarWarsPeople {
    var list: [Person]
    var next: String?

    init() {
        self.list = []
    }
}

class StarWarsPeopleViewModel {
    let layout: PeopleLayout
    var people = StarWarsPeople()
    var filteredPeople = StarWarsPeople()
    var showableList: ShowableList = .generic
    var alphabeticalOrder: AlphabeticalOrder?

    init(layout: PeopleLayout) {
        self.layout = layout
    }

    func updatePeople(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        StarWarsLogic.getPeopleResponse(queryParameters: people.next?.queryParameters) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.people.next = response.next
                guard !self.people.list.isEmpty
                else {
                    self.people.list = response.results
                    self.order()
                    completion(.success(()))
                    return
                }
                self.people.list.append(contentsOf: response.results)
                self.order()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchPeople(name: String,
                      completion: @escaping (Result<Void, NetworkError>) -> Void) {
        var queryParameters: [String: String] = filteredPeople.next?.queryParameters ?? [:]
        queryParameters["search"] = name
        StarWarsLogic.getPeopleResponse(queryParameters: queryParameters) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.filteredPeople.next = response.next
                guard !self.filteredPeople.list.isEmpty
                else {
                    self.filteredPeople.list = response.results
                    self.order()
                    completion(.success(()))
                    return
                }
                self.filteredPeople.list.append(contentsOf: response.results)
                self.order()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func order() {
        guard let alphabeticalOrder = alphabeticalOrder else {
            return
        }
        people.list.sort { (first, second) -> Bool in
            switch alphabeticalOrder {
            case .ascending:
                return first.name < second.name
            case .descending:
                return first.name > second.name
            }
        }
        filteredPeople.list.sort { (first, second) -> Bool in
            switch alphabeticalOrder {
            case .ascending:
                return first.name < second.name
            case .descending:
                return first.name > second.name
            }
        }
    }
}
