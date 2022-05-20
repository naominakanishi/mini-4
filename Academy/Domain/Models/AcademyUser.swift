import Foundation
import CloudKit

public struct AcademyUser: Hashable, Codable, Identifiable{
    
    public var id: String
    public let name: String
    public let email: String
    public let imageName: String
    public let status: Status?
    public let birthday: Date?
    public let role: Role?

    public init(id: String, name: String, email: String, imageName: String, status: Status?, birthday: Date?, role: Role?) {
        self.id = id
        self.name = name
        self.email = email
        self.imageName = imageName
        self.status = status
        self.birthday = birthday
        self.role = role
    }
    
}

public enum Status: Codable {
    case available, busy, offline
}

