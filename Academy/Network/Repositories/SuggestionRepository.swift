import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class SuggestionRepository: ObservableObject {
    
    static let shared = SuggestionRepository()
    
    private let path = "suggestion"
    private let store = Firestore.firestore()
    
    init() { }
    
    func create(suggestionData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path).document(id).setData(data) {
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
