import Combine

public final class AnnouncementUpdatingService {
    private let repository: AnnouncementRepository
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    init(repository: AnnouncementRepository) {
        self.repository = repository
    }
    
    public func execute(using announcement: Announcement) -> AnyPublisher<Bool, Error> {
        repository.update(announcement)
    }
}

