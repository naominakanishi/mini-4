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
        return repository
            .readingPublisher
            .decode(type: [Announcement].self, decoder: JSONDecoder())
            .map { $0.sorted { a1, a2 in
                a1.createdDate < a2.createdDate
            }}
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
