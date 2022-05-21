import Foundation

public struct Announcement: Codable, Hashable, Identifiable {
    public var id: String
    public var fromUser: AcademyUser
    public var createdTimeInterval: TimeInterval
    public var text: String
    public var isActive: Bool
    
    public let type: AnnouncementType?
    
    public var createdDate: Date {
        Date(timeIntervalSince1970: createdTimeInterval)
    }
    
    public init(id: String, fromUser: AcademyUser, createdTimeInterval: TimeInterval, text: String, isActive: Bool, type: AnnouncementType) {
        self.id = id
        self.fromUser = fromUser
        self.createdTimeInterval = createdTimeInterval
        self.text = text
        self.isActive = isActive
        self.type = type
    }
}


public enum AnnouncementType: String, Codable, CaseIterable {
    case announcement = "Aviso"
    case assignment = "Entrega"
}
