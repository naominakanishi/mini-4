import Foundation
import Academy
import Combine

final class SuggestionsBoxViewModel: ObservableObject {
    @Published var text: String = "Escreva aqui a sugestão"
    
    private let suggestionSenderService = SuggestionSenderService()
    
    private var cancelBag: [AnyCancellable] = []
    
    func sendSuggestion() {
        let suggestion = Suggestion(id: UUID().uuidString, text: text, createdDateString: Date().formatted())
        
        suggestionSenderService.send(suggestion: suggestion)
            .sink(receiveCompletion: { error in
                // TODO display error
            }, receiveValue: {
                if !$0 {
                    // TODO display error
                    return
                }
                
                // TODO display success
            })
            .store(in: &cancelBag)
    }
}
