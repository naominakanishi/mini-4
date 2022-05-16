import Foundation
import Combine

public final class AnnouncementListenerService {
    private let announcementRepository: AnnouncementRepository
    
    init(announcementRepository: AnnouncementRepository) {
        self.announcementRepository = announcementRepository
    }
    
    public convenience init() {
        self.init(announcementRepository: AnnouncementRepository())
    }
    
    public var activeAnnouncements: AnyPublisher<[Announcement], Never> {
        listen()
    }
    
    public func listen() -> AnyPublisher<[Announcement], Never> {
        return announcementRepository
            .read()
            .decode(type: [Announcement].self, decoder: JSONDecoder())
            .map { $0.sorted { a1, a2 in
                a1.createdDate < a2.createdDate
            }}
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
