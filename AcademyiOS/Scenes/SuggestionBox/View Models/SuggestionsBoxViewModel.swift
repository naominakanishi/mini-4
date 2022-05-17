import Foundation
import Academy

final class SuggestionsBoxViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var suggestionRepository = SuggestionRepository()
    
    func sendSuggestion() {
        let suggestion = Suggestion(id: UUID().uuidString, text: text, createdDateString: Date().formatted())
        
        suggestionRepository.create(suggestion)
    }
}
