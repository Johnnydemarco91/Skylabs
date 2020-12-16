import Foundation

public typealias Parameters = [String: Any]
public typealias ServiceData = Data

public enum Task {
    case requestPlain
    case requestJson(ServiceData)
}
