enum NetworkErrorCode: Int {
    case generic = 0
    case custom
}

struct NetworkError: Error {
    let description: String
    let code: NetworkErrorCode

    static func create(with text: String?) -> NetworkError {
        NetworkError(description: text ?? "Error found",
                     code: .generic)
    }
}
