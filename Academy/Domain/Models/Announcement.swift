import Foundation

public struct Announcement: Codable, Hashable, Identifiable {
    public let id: String
    public let fromUser: AcademyUser
    public let createdTimeInterval: TimeInterval
    public let headline: String?
    public let text: String
    public let isActive: Bool
    
    public let type: AnnouncementType?
    
    public var createdDate: Date {
        Date(timeIntervalSince1970: createdTimeInterval)
    }
    
    public init(id: String,
                fromUser: AcademyUser,
                createdTimeInterval: TimeInterval,
                text: String,
                isActive: Bool,
                type: AnnouncementType,
                headline: String?
    ) {
        self.id = id
        self.fromUser = fromUser
        self.createdTimeInterval = createdTimeInterval
        self.text = text
        self.isActive = isActive
        self.type = type
        self.headline = headline
    }
}


public enum AnnouncementType: String, Codable, CaseIterable {
    case announcement = "Aviso"
    case assignment = "Entrega"
}
