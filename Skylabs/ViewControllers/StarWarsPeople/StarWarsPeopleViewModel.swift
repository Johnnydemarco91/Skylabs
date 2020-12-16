enum PeopleLayout {
    case list
    case collection
}

class StarWarsPeopleViewModel {
    let layout: PeopleLayout
    var people = [People]()
    var next: String?

    init(layout: PeopleLayout) {
        self.layout = layout
    }

    func updatePeople(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
    }
}
