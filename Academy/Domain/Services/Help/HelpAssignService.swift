import Combine

public final class HelpAssignService {
    private let repository: HelpRepository
    
    init(repository: HelpRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func assign(using help: Help, currentUser: AcademyUser) -> AnyPublisher<Bool, Error> {
        repository.update(.init(
            id: help.id,
            user: help.user,
            title: help.title,
            description: help.description,
            type: help.type,
            currentLocation: help.currentLocation,
            requestTimeInterval: help.requestTimeInterval,
            assignee: currentUser,
            status: .beingHelped)
        )
    }
}
