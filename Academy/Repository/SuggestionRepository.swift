import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class SuggestionRepository: ObservableObject {
    
    private let path = "suggestion"
    private let store = Firestore.firestore()
    
    public init() { }
    
    public func create(_ suggestion: Suggestion) {
        do {
            _ = try store.collection(path).addDocument(from: suggestion)
        } catch {
            print(error.localizedDescription)
        }
    }
}
