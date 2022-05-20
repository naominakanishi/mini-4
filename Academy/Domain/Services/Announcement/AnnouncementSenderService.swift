import Combine

public class AnnouncementSenderService {
    private let repository: AnnouncementRepository
    
    init(repository: AnnouncementRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(content: String, user: AcademyUser, type: AnnouncementType) -> AnyPublisher<Bool, Error> {
        let announcement = Announcement(
            id: UUID().uuidString,
            fromUser: user,
            createdTimeInterval: Date.now.timeIntervalSince1970,
            text: content,
            isActive: true,
            type: type
        )
        
        do {
            let data = try announcement.toFirebase()
            return repository.create(announcementData: data)
        } catch let error {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
