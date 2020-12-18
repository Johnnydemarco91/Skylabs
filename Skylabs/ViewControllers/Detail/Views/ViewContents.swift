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
