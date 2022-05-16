import Foundation

public struct Announcement: Codable, Hashable, Identifiable {
    public var id: String
    // Review
    public var fromUser: User?
    public var createdTimeInterval: TimeInterval
    public var text: String
    public var isActive: Bool
    public var createdDate: Date {
        Date(timeIntervalSince1970: createdTimeInterval)
    }
    
    public init(id: String, createdTimeInterval: TimeInterval, text: String, isActive: Bool) {
        self.id = id
        self.createdTimeInterval = createdTimeInterval
        self.text = text
        self.isActive = isActive
    }
}
