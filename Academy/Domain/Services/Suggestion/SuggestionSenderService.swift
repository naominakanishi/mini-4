import Combine

public class SuggestionSenderService {
    private let repository: SuggestionRepository
    
    init(repository: SuggestionRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func send(suggestion: Suggestion) -> AnyPublisher<Bool, Error> {
        do {
            let data = try suggestion.toFirebase()
            return repository.create(suggestionData: data, id: suggestion.id)
        } catch let error {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
