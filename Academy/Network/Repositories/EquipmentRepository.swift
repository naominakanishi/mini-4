import Foundation
import Combine

final class EquipmentRepository: ObservableObject {
    
    static let shared = EquipmentRepository()
    
    private let path = "equipment"
    private var store: FirestoreRef {
        FirebaseProxy.shared.firestore()
    }
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(equipmentData data: [String: Any]) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path: path).addDocument(using: data) {
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
        store.collection(path: path).addSnapshotListener (callback: { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        
            guard let dictionaries = snapshot else { fatalError() }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        })
    }
    
    func update(_ equipment: Equipment) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path: path).document(id: equipment.id)
                .setData(using: equipment) {
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
