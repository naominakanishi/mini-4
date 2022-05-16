import Combine

public class AnnouncementSenderService {
    private let repository: AnnouncementRepository
    
    init(repository: AnnouncementRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(content: String) -> AnyPublisher<Bool, Error> {
        let announcement = Announcement(id: UUID().uuidString,
                                        createdTimeInterval: Date.now.timeIntervalSince1970,
                                        text: content,
                                        isActive: true)
        
        do {
            let data = try announcement.toFirebase()
            return repository.create(announcementData: data)
        } catch let error {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}

extension Encodable {
    func toFirebase() throws -> [String: Any] {
        let data: Data = try JSONEncoder().encode(self)
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            throw FirebaseDecodingError.invalidType
        }
        return dict
    }
}

enum FirebaseDecodingError: Error {
    case invalidType
}
