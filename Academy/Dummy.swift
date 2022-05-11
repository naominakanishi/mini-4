struct HTTP {
    func fetchAssignments() -> [Assignment] {
        [
            .init(type: .business, assignee: "teste"),
            .init(type: .progs, assignee: "progs"),
        ]
    }
}

public enum AssignmentType {
    case progs
    case design
    case business
}

public struct User: ExpressibleByStringLiteral {
    public let name: String
    let token: String
    
    public init(stringLiteral value: StringLiteralType) {
        name = value
        token = "dummy"
    }
}

public struct Assignment {
    let type: AssignmentType
    public let assignee: User
}

public struct FilterAssignment {
    
    let http: HTTP
    
    public init() {
        self.init(http: HTTP())
    }
    
    internal init(http: HTTP) {
        self.http = http
    }
    
    public func filter(byType type: AssignmentType) -> [Assignment] {
        http.fetchAssignments()
    }
}

