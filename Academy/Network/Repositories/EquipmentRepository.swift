import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class EquipmentRepository: ObservableObject {
    
    static let shared = EquipmentRepository()
    
    private let path = "equipment"
    private let store = Firestore.firestore()
    
    public init() {}
    
    public func read() -> AnyPublisher<Data, Never>{
        let publisher = PassthroughSubject<Data, Never>()
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            // Review
            guard let snapshot = snapshot else { fatalError() }
            
            let dictionaries: [[String: Any]] = snapshot.documents.map { $0.data() }
            let data = try! JSONSerialization.data(withJSONObject: dictionaries, options: [])
            
            publisher.send(data)
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    public func create(equipmentData data: [String: Any]) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path).addDocument(data: data) {
            if let _ = $0 {
                response.send(false)
                return
            }
            response.send(true)
        }
        return response
            .eraseToAnyPublisher()
    }
    
    public func update(_ equipment: Equipment) {
        
    }
}
