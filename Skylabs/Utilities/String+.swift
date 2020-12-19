import Foundation

extension String {
    public var queryParameters: [String: String]? {
        guard
            let url = URL(string: self),
            let components = URLComponents(url: url,
                                           resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return nil
        }
        return queryItems
            .reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
            }
    }
}

extension String {
    var year: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
