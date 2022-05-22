import Foundation
import Academy
import Combine
import SwiftUI
import AcademyUI

final class CalendarEventListViewModel: ObservableObject {
    
    private let listenerService = CalendarEventListenerService()
    
    @Published
    private(set) var calendar: [MonthModel] = []
    
    
    func handleOnAppear() {
        listenerService
            .listen()
            .map { self.getMonths(forDomainEvents: $0) }
            .assign(to: &$calendar)
    }
    
    private func getMonths(forDomainEvents events: [CalendarEvent]) -> [MonthModel] {
        Dictionary.init(grouping: events) { element in
            element.startDate.month
        }.map { (month, events) in
            MonthModel(name: month, from: events)
        }
    }
}


extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

extension MonthModel {
    init(name: String, from events: [CalendarEvent]) {
        self.init(name: name,
                  days: MonthModel.getDays(forDomainEvents: events))
    }
    
    private static func getDays(forDomainEvents events: [CalendarEvent]) -> [DayModel] {
        Dictionary(grouping: events) { $0.startDate.get(.day) }
            .map { (day, events) -> DayModel in
                .init(from: events,
                      name: events[0].startDate.dayOfTheWeek,
                      number: String(day)
                )
            }
    }
}

extension DayModel {
    init(from events: [CalendarEvent], name: String, number: String) {
        self.init(name: name, number: number, events: events.map { .init(from: $0) })
    }
}

extension EventModel {
    init(from event: CalendarEvent) {
        self.init(title: event.title,
                  color: .red,
                  emoji: event.emoji,
                  time: event.fullDay ? nil : event.startDate.hourMinute
        )
    }
}
