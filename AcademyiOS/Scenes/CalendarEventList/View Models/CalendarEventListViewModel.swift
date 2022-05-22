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
        events.groups(by: { $0.startDate.month }, sorting: { dict in
            dict.values.sorted {
                $0[0].startDate < $1[0].startDate
            }
        })
            .map { events in
            let month = events[0].startDate.month
            return MonthModel(name: month, from: events)
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
        events
            .groups(by: { $0.startDate.get(.day)}, sorting: { dict in
                dict.values.map { $0 }.sorted { $0[0].startDate < $1[0].startDate }
            })
            .map { events -> DayModel in
                let day = events[0].startDate.get(.day)
                return .init(from: events,
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
                  time: event.fullDay ? nil : event.startDate.hourMinute + " - " + event.endDate.hourMinute
        )
    }
}

public final class SequenceGroup<K, V>: Equatable where K: Equatable {
    let key: K
    var values: [V] = []
    
    init(key: K) {
        self.key = key
    }
    
    public static func == (lhs: SequenceGroup<K, V>, rhs: SequenceGroup<K, V>) -> Bool {
        lhs.key == rhs.key
    }
}

public extension Sequence {
    func groups<V>(by key: (Element) -> V, sorting: ([V: [Element]]) -> [[Element]]) -> [[Element]] where V: Hashable {
        var results: [V: [Element]] = [:]
        
        for element in self {
            let k = key(element)
            if let _ = results[k] {
                results[k]?.append(element)
            } else {
                results[k] = [element]
            }
        }
        
        return sorting(results)
    }
}

extension Sequence where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
