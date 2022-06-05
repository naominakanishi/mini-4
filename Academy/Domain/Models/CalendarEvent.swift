import Foundation
import Combine

public struct CalendarEvent: Codable, Identifiable {
    public var id: String
    public var title: String
    public var emoji: String
//    public var type: CalendarEventType = .nonOfficial
    public var fullDay: Bool
    public var startDateTimeInterval: TimeInterval
    public var endDateTimeInterval: TimeInterval
    
    public var startDate: Date {
        Date(timeIntervalSince1970: startDateTimeInterval)
    }
    public var endDate: Date {
        Date(timeIntervalSince1970: endDateTimeInterval)
    }
    
    public init(id: String, title: String, emoji: String, fullDay: Bool, startDateTimeInterval: TimeInterval, endDateTimeInterval: TimeInterval) {
        self.id = id
        self.title = title
        self.emoji = emoji
        self.fullDay = fullDay
        self.startDateTimeInterval = startDateTimeInterval
        self.endDateTimeInterval = endDateTimeInterval
    }
}

public enum CalendarEventType: String, Codable {
    case official = "Oficial"
    case nonOfficial = "Não oficial"
}
