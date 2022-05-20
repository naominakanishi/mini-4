import Foundation

public final class CalendarDay: Identifiable {
    public var id: String = UUID().uuidString
    public var day: Int
    public var month: Int
    public var year: Int
    public var calendarEvents: [CalendarEvent] = []
    
    public init(day: Int, month: Int, year: Int, calendarEvents: [CalendarEvent]) {
        self.day = day
        self.month = month
        self.year = year
        self.calendarEvents = calendarEvents
    }
}
