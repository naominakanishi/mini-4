import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class EquipmentRepository: ObservableObject {
    
    static let shared = EquipmentRepository()
    
    private let path = "equipment"
    private let store = Firestore.firestore()
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(equipmentData data: [String: Any]) -> AnyPublisher<Bool, Error> {
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
    
    private func read() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        
            guard let snapshot = snapshot else { fatalError() }
            
            let dictionaries: [[String : Any]] = snapshot.documents.map { $0.data() }
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        }
    }
    
    func update(_ equipment: Equipment) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path).document(equipment.id)
                .setData(from: equipment) {
                if let error = $0 {
                    response.send(false)
                    return
                }
                    
                response.send(true)
            }
        } catch {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
        
        return response
            .eraseToAnyPublisher()
    }
}
