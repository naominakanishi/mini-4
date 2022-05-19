import Combine

public class HelpSenderService {
    private let repository: HelpRepository
    
    init(repository: HelpRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(help: Help) -> AnyPublisher<Bool, Error> {
        do {
            let data = try help.toFirebase()
            return repository.create(helpData: data, id: help.id)
        } catch let error {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
