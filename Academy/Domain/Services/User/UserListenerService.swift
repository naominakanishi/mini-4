import Foundation
import Combine

public final class UserListenerService {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public convenience init() {
        self.init(userRepository: .shared)
    }
    
    public func listenUser(with id: String) -> AnyPublisher<AcademyUser, Never> {
        userRepository
            .fetchUser(with: id)
            .flatMap {
                Just($0)
                    .decode(type: AcademyUser.self, decoder: JSONDecoder.firebaseDecoder)
                    .replaceError(with: AcademyUser(id: "ERRO", name: "ERRO", email: "ERRO", imageName: "ERRO", status: nil, birthday: nil, role: nil, helpTags: []))
            }
            .eraseToAnyPublisher()
    }
    
}
