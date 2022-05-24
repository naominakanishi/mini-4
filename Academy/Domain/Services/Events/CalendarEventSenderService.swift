import Combine

enum EventError: Error {
    case tooLong
    case invalidDate
    case unhandledCase
}

public final class CalendarEventSenderService {
    private let repository: CalendarEventsRepository
    
    init(repository: CalendarEventsRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(title: String,
                     emoji: String,
                     isAllDay: Bool,
                     startDate: Date,
                     endDate: Date,
                     repeats: RepeatingFrequency
    ) -> AnyPublisher<Void, Error> {
        let distance = Int(startDate.distance(to: endDate))
        guard distance >= 0 else {
            return Fail(outputType: Void.self, failure: EventError.invalidDate)
                .eraseToAnyPublisher()
        }
        
        let nextExpirationDate = TimeConstants.nextExpirationDate
        let eventLenghtInDays = distance / Int(TimeConstants.secondsInADay) + 1
        
        var eventsToSend = [(Date, Date)]()
        for offset in 0..<eventLenghtInDays {
            print("LEN", eventLenghtInDays)
            
            let startDate = startDate.byAdding(.day, to: offset)
            let endDate = endDate.byAdding(.day, to: offset)
            let eventsToCreate: [(Date, Date)]
            
            switch repeats {
            case .never:
                eventsToCreate = [(startDate, endDate)]
            case .daily where eventLenghtInDays <= 1:
                eventsToCreate = zip(stride(from: startDate, to: nextExpirationDate, by: TimeConstants.secondsInADay),
                                     stride(from: endDate, to: nextExpirationDate, by: TimeConstants.secondsInADay)
                ).map { $0 }
            case .weekly where eventLenghtInDays <= 7:
                eventsToCreate = zip(stride(from: startDate, to: nextExpirationDate, by: TimeConstants.secondsInADay * 7),
                                     stride(from: endDate, to: nextExpirationDate, by: TimeConstants.secondsInADay * 7)
                ).map { $0 }
            case .everyTwoWeeks where eventLenghtInDays <= 14:
                eventsToCreate = zip(stride(from: startDate, to: nextExpirationDate, by: TimeConstants.secondsInADay * 14),
                                     stride(from: endDate, to: nextExpirationDate, by: TimeConstants.secondsInADay * 14)
                ).map { $0 }
            default:
                return Fail(outputType: Void.self, failure: EventError.unhandledCase)
                        .eraseToAnyPublisher()
            }
            eventsToSend.append(contentsOf: eventsToCreate)
        }
        
        return createEvents(title: title,
                            emoji: emoji,
                            isAllDay: isAllDay,
                            dates: eventsToSend)
    }
    
    private func createEvents(title: String,
                              emoji: String,
                              isAllDay: Bool,
                              dates: [(Date, Date)]
    ) -> AnyPublisher<Void, Error> {
        let events: [CalendarEvent] = dates.map { (startDate, endDate) in
            return .init(id: UUID().uuidString,
                         title: title,
                         emoji: emoji,
                         fullDay: isAllDay,
                         startDateTimeInterval: startDate.timeIntervalSince1970,
                         endDateTimeInterval: endDate.timeIntervalSince1970
            )
        }
        return send(events: events)
    }
    
    
    private func send(events: [CalendarEvent]) -> AnyPublisher<Void, Error> {
        do {
            let data = try events.map { try $0.toFirebase() }
            return repository.createBatch(eventData: data)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(outputType: Void.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}

public enum TimeConstants {
    public static let secondsInAMinute: TimeInterval = 60
    public static let secondsInAnHour: TimeInterval = secondsInAMinute * 60
    public static let secondsInADay: TimeInterval = secondsInAnHour * 24
    
    public static var nextExpirationDate: Date {
        let now = Date.now
        let august = Date.now
            .bySetting(.month, to: 8)
            .bySetting(.day, to: 1)
            .bySetting([.hour, .minute, .second], to: 0)
        let january = Date.now
            .byAdding(.year, to: 1)
            .bySetting([.month, .day], to: 1)
            .bySetting([.hour, .minute, .second], to: 0)
        
        if now.distance(to: august) < 0 {
            return january
        }
        return august
    }
    
    public static func secondsForMonth(_ month: Int) -> Int? {
        let year = Date.now.get(.year)
        let calendar = Calendar.current

        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year

        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year

        
        let startDate = calendar.date(from: startComps)!
        let endDate = calendar.date(from:endComps)!

        
        let diff = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)

        return diff.day
    }
}


public enum RepeatingFrequency: String, CaseIterable {
    case never = "Nunca"
    case daily = "Todo dia"
    case weekly = "Toda semana"
    case everyTwoWeeks = "A cada duas semanas"
}

extension Date {
    
    func bySetting(_ components: [Calendar.Component], to value: Int) -> Date {
        components.reduce(self) { partialResult, component in
            partialResult.bySetting(component, to: value)
        }
    }
    func bySetting(_ dateComponent: Calendar.Component, to value: Int) -> Date {
        Calendar.current.date(bySetting: dateComponent, value: value, of: self) ?? .now
    }
    
    func byAdding(_ dateComponent: Calendar.Component, to value: Int) -> Date {
        Calendar.current.date(byAdding: dateComponent, value: value, to: self) ?? .now
    }
}

extension Date: Strideable {
    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}
