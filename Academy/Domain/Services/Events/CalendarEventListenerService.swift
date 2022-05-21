import Combine

public final class CalendarEventListenerService {
    private let repository: CalendarEventsRepository
    
    init(repository: CalendarEventsRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func listen() -> AnyPublisher<[CalendarEvent], Never> {
        return repository
            .readingPublisher
            .decode(type: [CalendarEvent].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
