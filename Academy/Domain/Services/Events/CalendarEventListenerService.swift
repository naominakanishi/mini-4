import Combine

public final class CalendarEventListenerService {
    private let repository: CalendarEventsRepository
    
    init(repository: CalendarEventsRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public var todayEvents: AnyPublisher<[CalendarEvent], Never> {
        listen()
            .map { eventList in
                eventList.filter {
                    Calendar.current.isDateInToday($0.startDate)
                }
                .sorted { $0.startDate > $1.startDate }
            }
            .eraseToAnyPublisher()
    }
    
    public func listen() -> AnyPublisher<[CalendarEvent], Never> {
        return repository
            .readingPublisher
            .flatMap { data in
                Just(data)
                    .decode(type: [CalendarEvent].self, decoder: JSONDecoder.firebaseDecoder)
                    .replaceError(with: [])
            }
            .eraseToAnyPublisher()
    }
}

