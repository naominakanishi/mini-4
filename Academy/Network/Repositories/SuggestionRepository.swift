import Foundation
import Combine

final class SuggestionRepository: ObservableObject {
    
    static let shared = SuggestionRepository()
    
    private let path = "suggestion"
    private var store: FirestoreRef {
        FirebaseProxy.shared.firestore()
    }
    
    init() { }
    
    func create(suggestionData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path: path).document(id: id).setData(data: data) {
            if let _ = $0 {
                response.send(false)
                return
            }
            response.send(true)
        }
        return response
            .eraseToAnyPublisher()
    }
}
