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
    
    public func send(user: AcademyUser) -> AnyPublisher<Bool, Error> {
        let user = AcademyUser(
            id: user.id,
            name: user.name,
            email: user.email,
            imageName: "",
            status: .available,
            birthday: nil,
            role: .student
        )
        
        do {
            let data = try user.toFirebase()
            return repository.createUser(userData: data, with: user.id)
        } catch let error {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
