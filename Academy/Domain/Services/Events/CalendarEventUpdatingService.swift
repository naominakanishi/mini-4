import Combine

public final class CalendarEventUpdatingService {
    private let repository: CalendarEventsRepository
    
    init(repository: CalendarEventsRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func execute(using event: CalendarEvent) -> AnyPublisher<Bool, Error> {
        repository.update(event)
    }
}
