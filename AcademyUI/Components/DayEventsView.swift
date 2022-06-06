import SwiftUI
import Academy

public struct MonthView: View {
    let month: MonthModel
    let trailingView: AnyView
    
    public init(month: MonthModel) {
        self.init(month: month) {
            EmptyView()
        }
    }
    
    public init<V>(month: MonthModel, trailingView: () -> V) where V: View {
        self.month = month
        self.trailingView = AnyView(trailingView())
    }
    
    public var body: some View {
        VStack {
            if let name = month.name {
                HStack {
                    Text(name)
                        .font(.adaFontSubtitle)
                        .foregroundColor(Color.white)
                    Spacer()
                    trailingView
                }
            }
            VStack {
                ForEach(month.days) { day in
                    DayEventsView(model: day)
                }
            }
        }
    }
}

public struct DayEventsView: View {
    let model: DayModel
    
    public init(model: DayModel) {
        self.model = model
    }
    
    public var body: some View {
        HStack {
            VStack {
                Text(model.name)
                    .font(.adaTagTitle)
                Text(model.number)
                    .font(.calendarDayOfTheMonth)
            }
            VStack {
                ForEach(model.events) { event in
                    buildEventCard(event)
                }
            }
        }
        .padding(.all, DesignSystem.Spacing.cardInternalPadding)
        .background(Color.white.opacity(0.6).textFieldAdaGradient())
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private func buildEventCard(_ event: EventModel) -> some View {
        EventCard(event: event)
    }
}

public struct EventCard: View {
    
    let event: EventModel
    
    public init(event: EventModel) {
        self.event = event
    }
    
    public var body: some View {
        HStack {
            Text(event.emoji)
                .font(.system(size: 24, weight: .regular, design: .default))
                .padding()
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.system(size: 14, weight: .bold, design: .default))
                if let time = event.time {
                    Text(time)
                        .font(.system(size: 13, weight: .regular, design: .default))
                }
            }
            Spacer()
        }
        .background(Color.adaLightBlue.textFieldAdaGradient())
        .foregroundColor(Color.white)
        .cornerRadius(16)
    }
}

public struct MonthModel: Identifiable {
    public let id = UUID()
    let name: String?
    let days: [DayModel]
    
    public var hasEvents: Bool {
        days.isEmpty
    }
    
    public init(name: String?, days: [DayModel]) {
        self.name = name
        self.days = days
    }
}

public struct DayModel: Identifiable {
    public let id = UUID()
    let name: String
    let number: String
    let events: [EventModel]
    
    public init(name: String, number: String, events: [EventModel]) {
        self.name = name
        self.number = number
        self.events = events
    }
    
}

public struct EventModel: Identifiable {

    public let id = UUID()
    let title: String
    let color: Color
    let emoji: String
    let time: String?
    
    public init(title: String, color: Color, emoji: String, time: String?) {
        self.title = title
        self.color = color
        self.emoji = emoji
        self.time = time
    }
}

public extension MonthModel {
    init(name: String?, from events: [CalendarEvent]) {
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
                      number: String(format: "%02d", day)
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
