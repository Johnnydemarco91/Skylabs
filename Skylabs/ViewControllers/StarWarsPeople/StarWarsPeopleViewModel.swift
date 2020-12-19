import Foundation

enum PeopleLayout {
    case list
    case collection
}

class StarWarsPeopleViewModel {
    let layout: PeopleLayout
    var people = [Person]()
    var next: String?

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
}
