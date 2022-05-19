import Foundation
import Combine

public final class UserUpdatingService {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func update(with user: AcademyUser) -> AnyPublisher<Bool, Error> {
        repository.update(user)
    }
}
