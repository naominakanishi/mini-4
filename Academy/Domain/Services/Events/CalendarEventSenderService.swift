import Combine

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
                     endDate: Date
    ) -> AnyPublisher<Bool, Error> {
        Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
//        do {
//            let data = try event.toFirebase()
//            return repository.create(eventData: data, id: event.id)
//        } catch let error {
//            return Fail(outputType: Bool.self, failure: error)
//                .eraseToAnyPublisher()
//        }
    }
}
