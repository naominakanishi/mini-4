import Foundation

public struct Announcement: Hashable {
    public var id = UUID()
    public var fromUser: User
    public var date: Date
    public var text: String
    public var isActive: Bool
    
    public init(fromUser: User, date: Date, text: String, isActive: Bool) {
        self.fromUser = fromUser
        self.date = date
        self.text = text
        self.isActive = isActive
    }
}
