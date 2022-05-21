import Combine

public final class CalendarEventSenderService {
    private let repository: CalendarEventsRepository
    
    init(repository: CalendarEventsRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(event: CalendarEvent) -> AnyPublisher<Bool, Error> {
        do {
            let data = try event.toFirebase()
            return repository.create(eventData: data, id: event.id)
        } catch let error {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
