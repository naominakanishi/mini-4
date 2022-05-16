import Combine

public final class HelpUpdatingService {
    private let repository: HelpRepository
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    init(repository: HelpRepository) {
        self.repository = repository
    }
    
    public func execute(using help: Help) -> AnyPublisher<Bool, Error> {
        repository.update(help)
    }
}
