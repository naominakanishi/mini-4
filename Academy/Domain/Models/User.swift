import Foundation
import CloudKit

public struct User: Hashable, Codable {
    
    var id = UUID()
    public let name: String
    public let imageName: String
    let token: String
    public let status: Status?
    public let birthday: Date?
    public let role: Role?

    public init(id: UUID = UUID(), name: String, imageName: String, token: String, status: Status?, birthday: Date?, role: Role?) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.token = token
        self.status = status
        self.birthday = birthday
        self.role = role
    }
    
}

public enum Status: Codable {
    case available, busy, offline
}

