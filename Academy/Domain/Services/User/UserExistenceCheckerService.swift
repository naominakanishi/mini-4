import Foundation
import Combine

public class UserExistenceCheckerService {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func userExists(id: String) -> AnyPublisher<Bool, Never> {
        repository
            .checkIfUserExists(with: id)
    }
}
