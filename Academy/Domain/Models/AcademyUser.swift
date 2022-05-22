import Foundation

public struct AcademyUser: Hashable, Codable, Identifiable{
    
    public var id: String
    public let name: String
    public let email: String
    public let imageName: String
    public let status: Status?
    public let role: Role?
    public let helpTags: [HelpType]?
    
    public let birthday: TimeInterval?
    
    public init(id: String,
                name: String,
                email: String,
                imageName: String,
                status: Status?,
                birthday: TimeInterval?,
                role: Role?,
                helpTags: [HelpType]?
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.imageName = imageName
        self.status = status
        self.birthday = birthday
        self.role = role
        self.helpTags = helpTags
        
    }
}

public enum Status: Codable {
    case available, busy, offline
}

