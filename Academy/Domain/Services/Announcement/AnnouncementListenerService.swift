import Combine

public final class AnnouncementListenerService {
    private let repository: AnnouncementRepository
    
    init(repository: AnnouncementRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public var activeAnnouncements: AnyPublisher<[Announcement], Never> {
        listen()
    }
    
    public func listen() -> AnyPublisher<[Announcement], Never> {
        repository
            .readingPublisher
            .flatMap { data -> AnyPublisher<[Announcement], Never> in
                Just(data)
                    .decode(type: [Announcement].self, decoder: JSONDecoder.firebaseDecoder)
                    .replaceError(with: [])
                    .eraseToAnyPublisher()
            }
            .map { $0.sorted { a1, a2 in
                a1.createdDate > a2.createdDate
            }}
            .eraseToAnyPublisher()
    }
}
