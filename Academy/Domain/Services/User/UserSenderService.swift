import Foundation
import Combine

public class UserSenderService {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(user: AcademyUser) -> AnyPublisher<Void, Error> {
        let user = AcademyUser(
            id: user.id,
            name: user.name,
            email: user.email,
            imageName: user.imageName,
            status: .available,
            birthday: user.birthday,
            role: user.role ?? .student,
            helpTags: user.helpTags
        )
        
        do {
            let data = try user.toFirebase()
            return repository
                .createUser(userData: data, with: user.id)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(outputType: Void.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
