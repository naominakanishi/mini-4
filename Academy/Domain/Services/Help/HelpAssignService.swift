import Combine

public final class HelpAssignService {
    private let repository: HelpRepository
    
    init(repository: HelpRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func assign(using help: Help) -> AnyPublisher<Bool, Error> {
        var updatedHelp = help
        updatedHelp.status = .beingHelped
        
        // TO DO: Assign current user to help.assigne
        
        return repository.update(updatedHelp)
    }
}
