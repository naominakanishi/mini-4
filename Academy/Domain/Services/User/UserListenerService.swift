import Foundation
import Combine

protocol UserUpdating {
    func update(user: AcademyUser)
}

public final class UserListenerService {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public convenience init() {
        self.init(userRepository: .shared)
    }
    
    public var listener: AnyPublisher<AcademyUser, Never> {
        userRepository
            .currentUserPublisher
            .flatMap { userData -> AnyPublisher<AcademyUser?, Never> in
                Just(userData)
                    .decode(type: AcademyUser.self, decoder: JSONDecoder.firebaseDecoder)
                    .map { $0 }
                    .replaceError(with: nil)
                    .eraseToAnyPublisher()
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
