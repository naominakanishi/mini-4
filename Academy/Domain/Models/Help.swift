import Foundation

public struct Help: Codable, Identifiable {
    public var id: String
    public var title: String
    public var description: String
    public var type: HelpType
    public var currentLocation: String
    public var requestTimeInterval: TimeInterval
    public var assignee: User?
    public var requestDate: Date {
        Date(timeIntervalSince1970: requestTimeInterval)
    }
    
    public init(id: String, title: String, description: String, type: HelpType, currentLocation: String, requestTimeInterval: TimeInterval, assignee: User?) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.currentLocation = currentLocation
        self.requestTimeInterval = requestTimeInterval
        self.assignee = assignee
    }
}

extension Help: Hashable {
    public static func == (lhs: Help, rhs: Help) -> Bool {
        lhs.id == rhs.id
    }
}

public enum HelpType: String, Codable {
    case design = "Design"
    case code = "Progs"
    case business = "Business"
    case all = "Todos"
}
