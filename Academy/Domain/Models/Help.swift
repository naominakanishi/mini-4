import Foundation

public struct Help: Codable, Identifiable {
    public var id: String
    public var user: AcademyUser
    public var title: String
    public var description: String
    public var type: HelpType
    public var currentLocation: String
    public var requestTimeInterval: TimeInterval
    public var assignee: AcademyUser?
    public var status: HelpStatus = .waitingForHelp
    public var requestDate: Date {
        Date(timeIntervalSince1970: requestTimeInterval)
    }
    
    public init(id: String, user: AcademyUser, title: String, description: String, type: HelpType, currentLocation: String, requestTimeInterval: TimeInterval, assignee: AcademyUser?, status: HelpStatus) {
        self.id = id
        self.user = user
        self.title = title
        self.description = description
        self.type = type
        self.currentLocation = currentLocation
        self.requestTimeInterval = requestTimeInterval
        self.assignee = assignee
        self.status = status
    }
}

extension Help: Hashable {
    public static func == (lhs: Help, rhs: Help) -> Bool {
        lhs.id == rhs.id
    }
}

public enum HelpType: String, Codable, CaseIterable {
    case all = "Todos"
    case general = "Geral"
    case code = "Progs"
    case design = "Design"
    case business = "Business"
}

public enum HelpStatus: String, Codable {
    case waitingForHelp = "Aguardando ajuda"
    case beingHelped = "Ajuda recebida"
    case done = "Resolvido"
}
