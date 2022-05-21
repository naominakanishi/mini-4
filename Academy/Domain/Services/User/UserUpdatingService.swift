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
    
    public func update(with user: AcademyUser) -> AnyPublisher<AcademyUser, Error> {
        repository.update(user)
    }
    
    public func updateImage(_ imageData: Data, forUser user: AcademyUser) -> AnyPublisher<URL, Error> {
        repository
            .updateImage(using: imageData, usingFileName: user.id)
    }
}
