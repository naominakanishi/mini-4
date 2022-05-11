import Foundation

public struct Help {
    var id = UUID()
    public var title: String
    public var description: String
    public var type: HelpType
    public var currentLocation: String
    public var requestDate: Date
    public var assignee: User?
    
    public init(title: String, description: String, type: HelpType, currentLocation: String, requestDate: Date, assignee: User?) {
        self.title = title
        self.description = description
        self.type = type
        self.currentLocation = currentLocation
        self.requestDate = requestDate
        self.assignee = assignee
    }
}

extension Help: Hashable {
    public static func == (lhs: Help, rhs: Help) -> Bool {
        lhs.id == rhs.id
    }
}

public enum HelpType: String {
    case design = "Design"
    case code = "Progs"
    case business = "Business"
    case all = "Todos"
}
